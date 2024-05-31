//
//  DetailsInteractorTests.swift
//  CinemaStarTests
//
//  Created by Kate Volkova on 31.05.24.
//
@testable import CinemaStar
import Combine
import XCTest

final class DetailsInteractorTests: XCTestCase {
    private var detailsInteractor: DetailsInteractor?
    private var requestCancellable: AnyCancellable?
    private let mockNetworkService = MockNetworkService()
    private let mockLoadImageService = MockLoadImageService()
    private let mockStorageService = MockStorageService()
    private let movieId = 1234

    override func setUpWithError() throws {
        try super.setUpWithError()
        detailsInteractor = DetailsInteractor(
            networkService: mockNetworkService,
            loadImageService: mockLoadImageService,
            storageService: mockStorageService
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        detailsInteractor = nil
    }

    func testFetchDetailsSuccess() {
        mockNetworkService.shouldResultWithError = false
        let expectation = expectation(description: "fetchDetails success")
        requestCancellable = detailsInteractor?.fetchDetails(id: movieId)
            .receive(on: RunLoop.main)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Unexpected error")
                    expectation.fulfill()
                }
            } receiveValue: { [unowned self] value in
                XCTAssertEqual(
                    value.similarMovies.count,
                    mockNetworkService.expectedMovieDetails.similarMovies?.count
                )
                XCTAssertEqual(
                    value.actors.count,
                    mockNetworkService.expectedMovieDetails.actors.count
                )
                XCTAssertEqual(value.movieDetails, mockNetworkService.expectedMovieDetails)
                expectation.fulfill()
            }
        waitForExpectations(timeout: 3)
    }

    func testFetchMoviesAlsoFetchesImages() {
        mockNetworkService.shouldResultWithError = false
        let expectation = expectation(description: "fetchDetails fetches images")
        requestCancellable = detailsInteractor?.fetchDetails(id: movieId)
            .sink { [unowned self] completion in
                XCTAssertEqual(completion, .finished)
                guard let posterUrl = mockNetworkService.expectedMovieDetails.posterUrl,
                      let firstActorPhotoUrl = mockNetworkService.expectedMovieDetails.actors.first?.photoUrl,
                      let firstRecomPosterUrl = mockNetworkService.expectedMovieDetails.similarMovies?.first?.posterUrl
                else {
                    return
                }
                XCTAssert(mockLoadImageService.loadImageCallsWithUrls.contains(posterUrl))
                XCTAssert(mockLoadImageService.loadImageCallsWithUrls.contains(firstActorPhotoUrl))
                XCTAssert(mockLoadImageService.loadImageCallsWithUrls.contains(firstRecomPosterUrl))
                expectation.fulfill()
            } receiveValue: {_ in }

        waitForExpectations(timeout: 3)
    }

    func testFetchDetailsFailure() {
        mockNetworkService.shouldResultWithError = true
        let expectation = expectation(description: "fetchDetails failure")
        requestCancellable = detailsInteractor?.fetchDetails(id: movieId)
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

    func testSavesFavoriteFlagToStorage() {
        let isFavorite = true
        XCTAssertThrowsError(try detailsInteractor?.getIsFavorite(id: movieId))
        try? detailsInteractor?.saveFavorite(isFavorite: isFavorite, id: movieId)
        XCTAssertEqual(try? detailsInteractor?.getIsFavorite(id: movieId), isFavorite)
        XCTAssertEqual(mockStorageService.storeArray.count, 1)
    }
}
