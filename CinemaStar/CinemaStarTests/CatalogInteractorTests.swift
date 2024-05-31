//
//  CatalogInteractorTests.swift
//  CinemaStarTests
//
//  Created by Kate Volkova on 31.05.24.
//

@testable import CinemaStar
import Combine
import XCTest

final class CatalogInteractorTests: XCTestCase {
    private var catalogInteractor: CatalogInteractor?
    private var requestCancellable: AnyCancellable?
    private let mockNetworkService = MockNetworkService()
    private let mockLoadImageService = MockLoadImageService()

    override func setUpWithError() throws {
        try super.setUpWithError()
        catalogInteractor = CatalogInteractor(
            networkService: mockNetworkService,
            loadImageService: mockLoadImageService
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        catalogInteractor = nil
    }

    func testFetchMoviesSuccess() {
        mockNetworkService.shouldResultWithError = false
        let expectation = expectation(description: "fetchMovies success")
        requestCancellable = catalogInteractor?.fetchCatalog()
            .receive(on: RunLoop.main)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Unexpected error")
                    expectation.fulfill()
                }
            } receiveValue: { [unowned self] value in
                XCTAssertEqual(value.count, mockNetworkService.expectedMovies.count)
                XCTAssertEqual(value.first?.preview, mockNetworkService.expectedMovies.first)
                expectation.fulfill()
            }
        waitForExpectations(timeout: 3)
    }

    func testFetchMoviesAlsoFetchesPoster() {
        mockNetworkService.shouldResultWithError = false
        let expectation = expectation(description: "fetchMovies fetches poster")
        requestCancellable = catalogInteractor?.fetchCatalog()
            .sink { [unowned self] completion in
                XCTAssertEqual(completion, .finished)
                XCTAssertEqual(
                    mockLoadImageService.loadImageCallsWithUrls.last,
                    mockNetworkService.expectedMovies.first?.posterUrl
                )
                expectation.fulfill()
            } receiveValue: {_ in }

        waitForExpectations(timeout: 3)
    }

    func testFetchMoviesFailure() {
        mockNetworkService.shouldResultWithError = true
        let expectation = expectation(description: "fetchMovies failure")
        requestCancellable = catalogInteractor?.fetchCatalog()
            .receive(on: RunLoop.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .unknown)
                    expectation.fulfill()
                }
            } receiveValue: { _ in
                XCTFail("Unexpected. Must have thrown an error")
                expectation.fulfill()
            }
        waitForExpectations(timeout: 3)
    }
}
