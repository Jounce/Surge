// Copyright © 2014-2018 the Surge contributors
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

extension Array: UnsafeMemoryAccessible, UnsafeMutableMemoryAccessible {
    public func withUnsafeMemory<Result>(_ action: (UnsafeMemory<Element>) throws -> Result) rethrows -> Result {
        return try withUnsafeBufferPointer { ptr in
            guard let base = ptr.baseAddress else {
                fatalError("Array is missing its pointer")
            }
            let memory = UnsafeMemory(pointer: base, stride: 1, count: ptr.count)
            return try action(memory)
        }
    }

    public mutating func withUnsafeMutableMemory<Result>(_ action: (UnsafeMutableMemory<Element>) throws -> Result) rethrows -> Result {
        return try withUnsafeMutableBufferPointer { ptr in
            guard let base = ptr.baseAddress else {
                fatalError("Array is missing its pointer")
            }
            let memory = UnsafeMutableMemory(pointer: base, stride: 1, count: ptr.count)
            return try action(memory)
        }
    }
}
