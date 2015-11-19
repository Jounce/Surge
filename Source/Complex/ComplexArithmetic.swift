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

public func sum(x: ComplexArray) -> Complex {
    return Complex(real: sum(x.reals), imag: sum(x.imags))
}

// MARK: - Operators

public func +=(inout lhs: ComplexArray, rhs: ComplexArray) {
    lhs.reals += rhs.reals
    lhs.imags += rhs.imags
}


public func +(lhs: ComplexArray, rhs: ComplexArray) -> ComplexArray {
    var results = ComplexArray(lhs)
    results += rhs
    return results
}

public func -=(inout lhs: ComplexArray, rhs: ComplexArray) {
    lhs.reals -= rhs.reals
    lhs.imags -= rhs.imags
}


public func -(lhs: ComplexArray, rhs: ComplexArray) -> ComplexArray {
    var results = ComplexArray(lhs)
    results -= rhs
    return results
}

public func +=(inout lhs: ComplexArray, rhs: Complex) {
    lhs.reals += rhs.real
    lhs.imags += rhs.imag
}

public func +(lhs: ComplexArray, rhs: Complex) -> ComplexArray {
    var results = ComplexArray(lhs)
    results += rhs
    return results
}

public func +(lhs: Complex, rhs: ComplexArray) -> ComplexArray {
    var results = ComplexArray(rhs)
    results += lhs
    return results
}

public func -=(inout lhs: ComplexArray, rhs: Complex) {
    lhs.reals -= rhs.real
    lhs.imags -= rhs.imag
}

public func -(lhs: ComplexArray, rhs: Complex) -> ComplexArray {
    var results = ComplexArray(lhs)
    results -= rhs
    return results
}

public func -(lhs: Complex, rhs: ComplexArray) -> ComplexArray {
    var results = ComplexArray(rhs)
    results -= lhs
    return results
}

public func *=(inout lhs: ComplexArray, rhs: Real) {
    lhs.reals *= rhs
    lhs.imags *= rhs
}

public func *(lhs: ComplexArray, rhs: Real) -> ComplexArray {
    var results = ComplexArray(lhs)
    results *= rhs
    return results
}

public func /=(inout lhs: ComplexArray, rhs: Real) {
    lhs.reals /= rhs
    lhs.imags /= rhs
}

public func /(lhs: ComplexArray, rhs: Real) -> ComplexArray {
    var results = ComplexArray(lhs)
    results /= rhs
    return results
}
