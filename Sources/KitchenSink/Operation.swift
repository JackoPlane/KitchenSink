//
//  Operation.swift
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

/// Operation interface
public protocol OperationInterface {

    ///  Type of expected input
    associatedtype Input

    /// Type of output data
    associatedtype Output

    // MARK: - Properties

    /// Operation name
    var name: String { get }

    /// Information URL
    var infoUrl: URL? { get }

    /// Operation description, Markdown supported
    var description: String { get }

    // MARK: - Functions

    /// Operation execution
    /// - Parameter input: Input data
    /// - Returns: Processed output
    func execute(input: Input) async throws -> Output

}

/// Operation
open class Operation<Input, Output>: OperationInterface {

    // MARK: - Properties

    public let name: String
    public let infoUrl: URL?
    public let description: String

    /// Disabled status
    internal var disabled: Bool = false

    /// Flow control
    internal var flowControl: Bool = false

    /// Breakpoint
    internal var breakpoint: Bool = false

    // MARK: - Initializer

    internal init(name: String, description: String, infoUrl: URL? = nil) {
        self.name = name
        self.description = description
        self.infoUrl = infoUrl
    }

    // MARK: - Execution

    open func execute(input: Input) async throws -> Output {
        fatalError("Subclass must override: \(#function)", file: #file, line: #line)
    }

}
