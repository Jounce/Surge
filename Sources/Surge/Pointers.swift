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

// MARK: 2 Parameter

/// Invokes the given closure with pointers to the given arguments (2 parameter version).
///
/// - See: `withUnsafePointer(to:body:)`
@discardableResult
public func withUnsafePointers<A, B, Result>(_ a: inout A, _ b: inout B, body: (UnsafePointer<A>, UnsafePointer<B>) throws -> Result) rethrows -> Result {
    return try withUnsafePointer(to: &a) { (a: UnsafePointer<A>) throws -> Result in
        return try withUnsafePointer(to: &b) { (b: UnsafePointer<B>) throws -> Result in
            return try body(a, b)
        }
    }
}

/// Invokes the given closure with mutable pointers to the given arguments (2 parameter version).
///
/// - See: `withUnsafeMutablePointer(to:body:)`
@discardableResult
public func withUnsafeMutablePointers<A, B, Result>(_ a: inout A, _ b: inout B, body: (UnsafeMutablePointer<A>, UnsafeMutablePointer<B>) throws -> Result) rethrows -> Result {
    return try withUnsafeMutablePointer(to: &a) { (a: UnsafeMutablePointer<A>) throws -> Result in
        return try withUnsafeMutablePointer(to: &b) { (b: UnsafeMutablePointer<B>) throws -> Result in
            return try body(a, b)
        }
    }
}

// MARK: 3 Parameter

/// Invokes the given closure with pointers to the given arguments (3 parameter version).
///
/// - See: `withUnsafePointer(to:body:)`
@discardableResult
public func withUnsafePointers<A, B, C, Result>(_ a: inout A, _ b: inout B, _ c: inout C, body: (UnsafePointer<A>, UnsafePointer<B>, UnsafePointer<C>) throws -> Result) rethrows -> Result {
    return try withUnsafePointer(to: &a) { (a: UnsafePointer<A>) throws -> Result in
        return try withUnsafePointer(to: &b) { (b: UnsafePointer<B>) throws -> Result in
            return try withUnsafePointer(to: &c) { (c: UnsafePointer<C>) throws -> Result in
                return try body(a, b, c)
            }
        }
    }
}

/// Invokes the given closure with mutable pointers to the given arguments (3 parameter version).
///
/// - See: `withUnsafeMutablePointer(to:body:)`
@discardableResult
public func withUnsafeMutablePointers<A, B, C, Result>(_ a: inout A, _ b: inout B, _ c: inout C, body: (UnsafeMutablePointer<A>, UnsafeMutablePointer<B>, UnsafeMutablePointer<C>) throws -> Result) rethrows -> Result {
    return try withUnsafeMutablePointer(to: &a) { (a: UnsafeMutablePointer<A>) throws -> Result in
        return try withUnsafeMutablePointer(to: &b) { (b: UnsafeMutablePointer<B>) throws -> Result in
            return try withUnsafeMutablePointer(to: &c) { (c: UnsafeMutablePointer<C>) throws -> Result in
                return try body(a, b, c)
            }
        }
    }
}
