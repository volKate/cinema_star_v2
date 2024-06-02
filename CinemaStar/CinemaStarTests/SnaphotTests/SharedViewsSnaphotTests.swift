//
//  SharedViewsSnaphotTests.swift
//  CinemaStarTests
//
//  Created by Kate Volkova on 1.06.24.
//

@testable import CinemaStar
import SnapshotTesting
import SwiftUI
import XCTest

final class SharedViewsSnaphotTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBackgroundView() {
        let bgView = BackgroundView {
            Text("Test")
        }
        let view: UIView = UIHostingController(rootView: bgView).view

        assertSnapshot(
            matching: view,
            as: .image(size: CGSize(width: 390, height: 830))
        )
    }

    func testMovieCardView() {
        let movieCardView = MovieCardView(posterImage: Image(.posterPlaceholder), name: "Test movie name")
        let view: UIView = UIHostingController(rootView: movieCardView).view

        assertSnapshot(
            matching: view,
            as: .image(size: view.intrinsicContentSize)
        )
    }

    func testMovieCardWithRatingView() {
        let movieCardView = MovieCardView(
            posterImage: Image(.posterPlaceholder),
            name: "Test movie name",
            rating: 5.7
        )
        let view: UIView = UIHostingController(rootView: movieCardView).view

        assertSnapshot(
            matching: view,
            as: .image(size: view.intrinsicContentSize)
        )
    }

    func testRatingView() {
        let ratingView = RatingView(5.6)
        let view: UIView = UIHostingController(rootView: ratingView).view

        assertSnapshot(
            matching: view,
            as: .image(size: view.intrinsicContentSize)
        )
    }

    func testNoDataMessageView() {
        let messageView = NoDataMessageView()
        let view: UIView = UIHostingController(rootView: messageView).view

        assertSnapshot(
            matching: view,
            as: .image(size: view.intrinsicContentSize)
        )
    }

    func testErrorMessageView() {
        let messageView = ErrorMessageView()
        let view: UIView = UIHostingController(rootView: messageView).view

        assertSnapshot(
            matching: view,
            as: .image(size: view.intrinsicContentSize)
        )
    }
}
