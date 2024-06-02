//
//  MoviesCachableRequest.swift
//  CinemaStar
//
//  Created by Kate Volkova on 1.06.24.
//

import Combine
import CoreData
import Foundation

/// Кэшируемый запрос фильмов
final class MoviesCachableRequest: CachableRequestProtocol {
    typealias ModelType = [MoviePreview]
    typealias EntityType = MovieEntity

    private(set) var reqPublisher: Future<[MoviePreview], NetworkError>

    init(reqPublisher: Future<[MoviePreview], NetworkError>) {
        self.reqPublisher = reqPublisher
    }

    func prepareDataForSave(_ movies: [MoviePreview], context: NSManagedObjectContext) {
        for movie in movies {
            let movieEntity = MovieEntity(context: context)
            mapModelToEntity(movie, movieEntity)
        }
    }

    func mapDataFromCache(_ cache: [MovieEntity]) -> [MoviePreview] {
        cache.map(mapEntityToModel)
    }

    func cacheFetchRequest() -> NSFetchRequest<MovieEntity> {
        MovieEntity.fetchRequest()
    }

    private func mapModelToEntity(_ movie: MoviePreview, _ movieEntity: MovieEntity) {
        movieEntity.id = Int64(movie.id)
        movieEntity.name = movie.name
        movieEntity.rating = movie.rating
        movieEntity.posterUrl = movie.posterUrl?.absoluteString
    }

    private func mapEntityToModel(_ entity: MovieEntity) -> MoviePreview {
        MoviePreview(
            id: Int(entity.id),
            name: entity.name ?? "",
            posterUrl: entity.posterUrl != nil ? URL(string: entity.posterUrl ?? "") : nil,
            rating: entity.rating
        )
    }
}
