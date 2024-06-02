//
//  NetworkServiceProxy.swift
//  CinemaStar
//
//  Created by Kate Volkova on 31.05.24.
//

import Combine
import CoreData
import Foundation
import Network

/// Прокси запросов в сеть с кэшированием в CoreData
final class NetworkServiceProxy: NetworkServiceProtocol {
    private var cancellablesSet: Set<AnyCancellable> = []
    private var isConnectedToNetwork = false
    private let monitor = NWPathMonitor()
    private let service: NetworkServiceProtocol
    private let stack: CoreDataStack

    init(service: NetworkServiceProtocol, stack: CoreDataStack) {
        self.service = service
        self.stack = stack
        setupNetworkMonitoring()
    }

    private func load<R: CachableRequestProtocol>(request: R) -> Future<R.ModelType, NetworkError> {
        return Future { [unowned self] promise in
            if isConnectedToNetwork {
                request.reqPublisher
                    .sink { completion in
                        if case let .failure(err) = completion {
                            promise(.failure(err))
                        }
                    } receiveValue: { [unowned self] data in
                        promise(.success(data))
                        request.prepareDataForSave(data, context: stack.viewContext)
                        stack.saveContext()
                    }
                    .store(in: &cancellablesSet)
            } else {
                do {
                    let cachedData = try loadCachedData(fetchReq: request.cacheFetchRequest())
                    if cachedData.isEmpty {
                        promise(.failure(.noData))
                    } else {
                        do {
                            let data = try request.mapDataFromCache(cachedData)
                            promise(.success(data))
                        } catch {
                            promise(.failure(.noData))
                        }
                    }
                } catch {
                    promise(.failure(.connection))
                }
            }
        }
    }

    func loadMovies() -> Future<[MoviePreview], NetworkError> {
        load(request: MoviesCachableRequest(reqPublisher: service.loadMovies()))
    }

    func loadMovieDetails(id: Int) -> Future<MovieDetails, NetworkError> {
        load(
            request: MovieDetailsCachableRequest(
                reqPublisher: service.loadMovieDetails(id: id),
                id: id
            )
        )
    }

    private func loadCachedData<T>(fetchReq: NSFetchRequest<T>) throws -> [T] {
        return try stack.viewContext.fetch(fetchReq)
    }

    private func setupNetworkMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isConnectedToNetwork = true
            } else {
                self?.isConnectedToNetwork = false
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
