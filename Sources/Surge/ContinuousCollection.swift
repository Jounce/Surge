// Copyright (c) 2017 Alejandro Isaza
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

/// A collection that has a C array representation: a continuous block of memory.
public protocol ContinuousCollection: Collection {
    /// Calls a closure with a pointer to the array's contiguous storage.
    ///
    /// The pointer passed as an argument to `body` is valid only during the execution of
    /// `withUnsafeBufferPointer(_:)`. Do not store or return the pointer for later use.
    ///
    /// - Parameter body: A closure with an `UnsafeBufferPointer` parameter that points to the contiguous storage for
    ///   the array.  If `body` has a return value, that value is also used as the return value for the
    ///   `withUnsafeBufferPointer(_:)` method. The pointer argument is valid only for the duration of the method's
    ///   execution.
    /// - Returns: The return value, if any, of the `body` closure parameter.
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R
}

/// A mutable collection that has a C array representation: a continuous block of memory.
public protocol ContinuousMutableCollection: ContinuousCollection {
    /// Calls the given closure with a pointer to the array's mutable contiguous storage.
    ///
    /// The pointer passed as an argument to `body` is valid only during the execution of
    /// `withUnsafeMutableBufferPointer(_:)`. Do not store or return the pointer for later use.
    ///
    /// - Parameter body: A closure with an `UnsafeMutableBufferPointer` parameter that points to the contiguous
    ///   storage for the array. If `body` has a return value, that value is also used as the return value for the
    ///   `withUnsafeMutableBufferPointer(_:)` method. The pointer argument is valid only for the duration of the
    ///   method's execution.
    /// - Returns: The return value, if any, of the `body` closure parameter.
    mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R
}

extension Array: ContinuousMutableCollection {}
extension ContiguousArray: ContinuousMutableCollection {}
extension ArraySlice: ContinuousMutableCollection {}
