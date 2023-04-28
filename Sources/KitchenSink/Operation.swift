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
    func execute(input: Data) async throws -> ConvertibleIntoData

}

/// Operation
open class Operation: OperationInterface, Presentable {

    // MARK: - Properties

    /// Disabled status
    open var disabled: Bool = false

    /// Flow control
    open var flowControl: Bool = false

    /// Breakpoint
    open var breakpoint: Bool = false

    // MARK: - OperationInterface

    public var name: String {
        fatalError("Subclass must override: \(#function)", file: #file, line: #line)
    }

    public var infoUrl: URL? {
        nil
    }

    public var description: String {
        fatalError("Subclass must override: \(#function)", file: #file, line: #line)
    }

    // MARK: - Execution

    public func execute(input: Data) async throws -> ConvertibleIntoData {
        fatalError("Subclass must override: \(#function)", file: #file, line: #line)
    }

    // MARK: - Presentable

    public func prepareForPresentation(_ input: Data) -> Renderable {
        fatalError("Subclass must override: \(#function)", file: #file, line: #line)
    }

}

public protocol Presentable {

    func prepareForPresentation(_ input: Data) -> Renderable

}

public enum Renderable {

    case string(_ value: String)

}
