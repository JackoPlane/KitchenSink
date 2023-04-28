//
//  ToHexOperationTests.swift
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

final class ToHexOperationTests: XCTestCase {

    private var testSubject: ToHexOperation!

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        try super.setUpWithError()

        testSubject = .init()
    }

    // MARK: - Tests

    func testMetadata() {
        XCTAssertEqual(testSubject.name, "To Hex")
        XCTAssertNotNil(testSubject.description)
        XCTAssertEqual(testSubject.infoUrl, URL(string: "https://wikipedia.org/wiki/Hexadecimal"))
    }

    func testBasicOperations() async throws {
        let testInput1 = "Hello World!".data(using: .utf8)!
        let output = try await testSubject.execute(input: testInput1)
        let result = try output.asData()
        XCTAssertEqual(result, "48 65 6c 6c 6f 20 57 6f 72 6c 64 21".data(using: .utf8)!)
    }

    func testNaughtyStringValues() async throws {
        let inputs: [Data: String] = [
            "Γειά σου".data(using: .utf8)!: "ce 93 ce b5 ce b9 ce ac 20 cf 83 ce bf cf 85",
            "𠜎𠜱𠝹𠱓𠱸𠲖𠳏".data(using: .utf8)!: "f0 a0 9c 8e f0 a0 9c b1 f0 a0 9d b9 f0 a0 b1 93 f0 a0 b1 b8 f0 a0 b2 96 f0 a0 b3 8f",
            "表ポあA鷗ŒéＢ逍Üßªąñ丂㐀𠀀".data(using: .utf8)!: "e8 a1 a8 e3 83 9d e3 81 82 41 e9 b7 97 c5 92 c3 a9 ef bc a2 e9 80 8d c3 9c c3 9f c2 aa c4 85 c3 b1 e4 b8 82 e3 90 80 f0 a0 80 80",
            "👨‍🦰 👨🏿‍🦰 👨‍🦱 👨🏿‍🦱 🦹🏿‍♂️".data(using: .utf8)!: "f0 9f 91 a8 e2 80 8d f0 9f a6 b0 20 f0 9f 91 a8 f0 9f 8f bf e2 80 8d f0 9f a6 b0 20 f0 9f 91 a8 e2 80 8d f0 9f a6 b1 20 f0 9f 91 a8 f0 9f 8f bf e2 80 8d f0 9f a6 b1 20 f0 9f a6 b9 f0 9f 8f bf e2 80 8d e2 99 82 ef b8 8f",
            "הָיְתָהtestالصفحات التّحول".data(using: .utf8)!: "d7 94 d6 b8 d7 99 d6 b0 d7 aa d6 b8 d7 94 74 65 73 74 d8 a7 d9 84 d8 b5 d9 81 d8 ad d8 a7 d8 aa 20 d8 a7 d9 84 d8 aa d9 91 d8 ad d9 88 d9 84",
            "𝕿𝖍𝖊 𝖖𝖚𝖎𝖈𝖐 𝖇𝖗𝖔𝖜𝖓 𝖋𝖔𝖝 𝖏𝖚𝖒𝖕𝖘 𝖔𝖛𝖊𝖗 𝖙𝖍𝖊 𝖑𝖆𝖟𝖞 𝖉𝖔𝖌".data(using: .utf8)!: "f0 9d 95 bf f0 9d 96 8d f0 9d 96 8a 20 f0 9d 96 96 f0 9d 96 9a f0 9d 96 8e f0 9d 96 88 f0 9d 96 90 20 f0 9d 96 87 f0 9d 96 97 f0 9d 96 94 f0 9d 96 9c f0 9d 96 93 20 f0 9d 96 8b f0 9d 96 94 f0 9d 96 9d 20 f0 9d 96 8f f0 9d 96 9a f0 9d 96 92 f0 9d 96 95 f0 9d 96 98 20 f0 9d 96 94 f0 9d 96 9b f0 9d 96 8a f0 9d 96 97 20 f0 9d 96 99 f0 9d 96 8d f0 9d 96 8a 20 f0 9d 96 91 f0 9d 96 86 f0 9d 96 9f f0 9d 96 9e 20 f0 9d 96 89 f0 9d 96 94 f0 9d 96 8c",
        ]

        for (input, expectedValue) in inputs {
            let output = try await testSubject.execute(input: input)
            let result = try output.asData()
            XCTAssertEqual(result, expectedValue.data(using: .utf8)!)
        }

    }

}
