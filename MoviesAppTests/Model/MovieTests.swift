//
//  MovieTests.swift
//  MoviesAppTests
//
//  Created by Tarek on 03/04/2021.
//

import Foundation
import XCTest
@testable import MoviesApp
class MovieTests: XCTestCase {
    
    func testYearFormat() {
        let movie = Movie(releaseDate: "2020-03-04")
        XCTAssertFalse(movie._year == nil)
        XCTAssertEqual(movie._year, "2020")
    }
    
    func testImagePath() {
        let path = "testPath"
        let movie = Movie(imagePath: path)
        XCTAssertFalse(movie._imageURL == nil)
        XCTAssertEqual(movie._imageURL, "https://image.tmdb.org/t/p/w500/\(path)")
    }
    
}
