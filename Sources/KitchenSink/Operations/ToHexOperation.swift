//
//  ToHexOperation.swift
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

import Foundation

/// To Hex operation
final public class ToHexOperation: Operation {

    // MARK: - Metadata

    public override var name: String {
        "To Hex"
    }

    public override var description: String {
        // swiftlint:disable:next line_length
        "Converts the input string to hexadecimal bytes separated by the specified delimiter.\n\ne.g. The UTF-8 encoded string `Γειά σου` becomes `ce 93 ce b5 ce b9 ce ac 20 cf 83 ce bf cf 85 0a"
    }

    public override var infoUrl: URL? {
        URL(string: "https://wikipedia.org/wiki/Hexadecimal")
    }

    // MARK: - Execution

    public override func execute(input: Data) async throws -> ConvertibleIntoData {
        // Once we  have support for passing ingredients, I'd like
        // to support a wider range of delimiters
        let delimiter = " "
        let separator = "" // Will be used when using 0x with comma formatting

        let hexString = input.map { String(format: "%02x\(delimiter)", $0) }.joined(separator: separator)

        return String(hexString.dropLast(delimiter.count))
    }

    // MARK: - Rendering

    public override func prepareForPresentation(_ input: Data) -> Renderable {
        .string(String(data: input, encoding: .utf8)!)
    }

}
