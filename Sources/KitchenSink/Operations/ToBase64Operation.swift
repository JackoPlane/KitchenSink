//
//  ToBase64Operation.swift
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

/// To Base64 operation
final public class ToBase64Operation: Operation {

    // MARK: - Metadata

    public override var name: String {
        "To Base64"
    }

    public override var description: String {
        // swiftlint:disable:next line_length
        "Base64 is a notation for encoding arbitrary byte data using a restricted set of symbols that can be conveniently used by humans and processed by computers.\n\nThis operation encodes raw data into an ASCII Base64 string.\n\ne.g. `hello` becomes `aGVsbG8=`"
    }

    public override var infoUrl: URL? {
        URL(string: "https://wikipedia.org/wiki/Base64")
    }

    // MARK: - Execution

    public override func execute(input: Data) async throws -> ConvertibleIntoData {
        return input.base64EncodedString()
    }

    // MARK: - Rendering

    public override func prepareForPresentation(_ input: Data) -> Renderable {
        .string(String(data: input, encoding: .utf8)!)
    }

}
