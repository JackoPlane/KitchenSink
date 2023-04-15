//
//  RecipeTests.swift
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

final class RecipeTests: XCTestCase {

    private var testSubject: Recipe!

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        try super.setUpWithError()

        testSubject = .init([])
    }

    // MARK: - Tests

    func testOperationAppending() {
        // GIVEN we don't have any operations currently
        XCTAssertTrue(testSubject.operations.isEmpty)

        // WHEN we append a example operation
        testSubject.addOperation(Operation<String, String>(name: "Test", description: "Testing"))

        // THEN we have 1 operation stored in the recipe
        XCTAssertEqual(testSubject.operations.count, 1)
    }

    func testMultipleOperationAppending() {
        // GIVEN we don't have any operations currently
        XCTAssertTrue(testSubject.operations.isEmpty)

        // WHEN we append multiple operations
        testSubject.addOperations([
            Operation<String, String>(name: "Test", description: "Testing"),
            Operation<String, String>(name: "Test", description: "Testing"),
            Operation<String, String>(name: "Test", description: "Testing"),
            Operation<String, String>(name: "Test", description: "Testing"),
        ])

        // THEN expect 4 operations contained within the array
        XCTAssertEqual(testSubject.operations.count, 4)

        // WHEN appending an empty array
        testSubject.addOperations([])

        // THEN expect the array size to not have changed
        XCTAssertEqual(testSubject.operations.count, 4)
    }

    func testBreakpointToggling() {
        // GIVEN we append a operation to our recipe
        testSubject.addOperation(Operation<String, String>(name: "Test", description: "Testing"))

        // THEN expect the breakpoint is disabled by default
        XCTAssertEqual(testSubject.operations.first?.breakpoint, false)

        // WHEN we set a breakpoint on index 0
        testSubject.setBreakpoint(0, enabled: true)

        // THEN expect the breakpoint is enabled
        XCTAssertEqual(testSubject.operations.first?.breakpoint, true)

        // WHEN we then disable the recently enabled breakpoint
        testSubject.setBreakpoint(0, enabled: false)

        // THEN expect the breakpoint is disabled again
        XCTAssertEqual(testSubject.operations.first?.breakpoint, false)
    }

    func testRemoveBreakpoints() {
        // GIVEN we append some operations to our recipe
        testSubject.addOperations([
            Operation<String, String>(name: "Test", description: "Testing"),
            Operation<String, String>(name: "Test", description: "Testing"),
            Operation<String, String>(name: "Test", description: "Testing"),
            Operation<String, String>(name: "Test", description: "Testing"),
        ])

        // THEN expect only default values for breakpoint state
        XCTAssertEqual(
            testSubject.operations.map(\.breakpoint),
            [false, false, false, false]
        )

        // WHEN we enable all breakpoints and then disable up to the 2nd index
        for index in 0..<testSubject.operations.count {
            testSubject.setBreakpoint(index, enabled: true)
        }

        testSubject.removeBreakpoints(upTo: 2)

        // THEN expect the all breakpoints in the first 2 indexes to be disabled
        XCTAssertEqual(
            testSubject.operations.map(\.breakpoint),
            [false, false, true, true]
        )
    }

    func testExecuteInvalidStartIndex() async {
        do {
            // WHEN we execute with a invalid starting index
            let startIndex = testSubject.operations.count + 1
            _ = try await testSubject.execute(dish: String(), startFrom: startIndex)
            XCTFail("Recipe.Error.invalidStartIndex should have been thrown")
        } catch {
            // THEN Confirm the error thrown is `Recipe.Error.invalidStartIndex`
            XCTAssertEqual(error as? Recipe.Error, .invalidStartIndex)
        }
    }

}
