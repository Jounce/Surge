// Copyright © 2015 Venture Media Labs.
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

public protocol DoubleType {}
public protocol FloatType {}

extension Double: DoubleType {}
extension Float: FloatType {}
extension Complex: DoubleType {}

public func doublePointer<T: DoubleType>(array: [T]) -> UnsafePointer<Double> {
    return array.withUnsafeBufferPointer{ UnsafePointer<Double>(UnsafePointer<Void>($0.baseAddress)) }
}

public func mutableDoublePointer<T: DoubleType>(inout array: [T]) -> UnsafeMutablePointer<Double> {
    return UnsafeMutablePointer<Double>(doublePointer(array))
}

public func floatPointer<T: FloatType>(array: [T]) -> UnsafePointer<Float> {
    return array.withUnsafeBufferPointer{ UnsafePointer<Float>(UnsafePointer<Void>($0.baseAddress)) }
}

public func mutableFloatPointer<T: FloatType>(inout array: [T]) -> UnsafeMutablePointer<Float> {
    return UnsafeMutablePointer<Float>(floatPointer(array))
}
