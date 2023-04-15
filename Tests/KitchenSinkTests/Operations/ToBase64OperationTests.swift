//
//  ToBase64OperationTests.swift
//
//  Copyright (c) 2023 Jack Perry <github@jckpry.me>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
import Foundation
@testable import KitchenSink

final class ToBase64OperationTests: XCTestCase {

    private var testSubject: ToBase64Operation!

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        try super.setUpWithError()

        testSubject = .init()
    }

    // MARK: - Tests

    func testMetadata() {
        XCTAssertEqual(testSubject.name, "To Base64")
        XCTAssertNotNil(testSubject.description)
        XCTAssertEqual(testSubject.infoUrl, URL(string: "https://wikipedia.org/wiki/Base64"))
    }

    func testBasicOperations() async throws {
        let testInput1 = "Hello World!".data(using: .utf8)!
        let output = try await testSubject.execute(input: testInput1)
        XCTAssertEqual(output, "SGVsbG8gV29ybGQh")
    }

    func testRFCValues() async throws {
        let inputs: [Data: String] = [
            "".data(using: .utf8)!: "",
            "f".data(using: .utf8)!: "Zg==",
            "fo".data(using: .utf8)!: "Zm8=",
            "foo".data(using: .utf8)!: "Zm9v",
            "foob".data(using: .utf8)!: "Zm9vYg==",
            "fooba".data(using: .utf8)!: "Zm9vYmE=",
            "foobar".data(using: .utf8)!: "Zm9vYmFy"
        ]

        for (input, expectedValue) in inputs {
            let output = try await testSubject.execute(input: input)
            XCTAssertEqual(output, expectedValue)
        }

    }

}
