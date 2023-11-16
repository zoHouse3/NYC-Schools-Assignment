//
//  SchoolsUnitTests.swift
//  SchoolsUnitTests
//
//  Created by Eric Barnes - iOS on 11/16/23.
//

import XCTest

final class SchoolsUnitTests: XCTestCase {

    // Test that we are properly creating query urls based off given dbn
    func testUrlQueryComponent() {
        let testDBN = "123ABC"
        let sut = DetailViewViewModel(dbn: testDBN)
        let actual = sut.createURLQuery(baseUrlString: "https://test.json", queryName: "id", queryValue: testDBN).absoluteString
        let expected = "https://test.json?id=123ABC"
        
        XCTAssertEqual(actual, expected)
    }

}
