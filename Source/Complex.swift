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

import Accelerate

public struct Complex : CustomStringConvertible {
    public var real: Real = 0.0
    public var imag: Real = 0.0

    public init() {}

    public init(real: Real, imag: Real) {
        self.real = real
        self.imag = imag
    }

    public var magnitude: Real {
        return hypot(real, imag)
    }
    public var phase: Real {
        return atan2(imag, real)
    }

    public var description: String {
        return "\(real) + \(imag)i"
    }
}

extension Complex: RealType {}

public func + (lhs: Complex, rhs: Complex) -> Complex {
    return Complex(real: lhs.real + rhs.real, imag: lhs.imag + rhs.imag)
}

public func - (lhs: Complex, rhs: Complex) -> Complex {
    return Complex(real: lhs.real - rhs.real, imag: lhs.imag - rhs.imag)
}

public func * (lhs: Complex, rhs: Complex) -> Complex {
    return Complex(real: lhs.real * rhs.real - lhs.imag * rhs.imag, imag: lhs.real * rhs.imag + lhs.imag * rhs.real)
}

public func * (x: Complex, a: Real) -> Complex {
    return Complex(real: x.real * a, imag: x.imag * a)
}

public func * (a: Real, x: Complex) -> Complex {
    return Complex(real: x.real * a, imag: x.imag * a)
}

public func / (lhs: Complex, rhs: Complex) -> Complex {
    let rhsMagSq = rhs.real*rhs.real + rhs.imag*rhs.imag
    return Complex(
        real: (lhs.real*rhs.real + lhs.imag*rhs.imag) / rhsMagSq,
        imag: (lhs.imag*rhs.real - lhs.real*rhs.imag) / rhsMagSq)
}

public func / (x: Complex, a: Real) -> Complex {
    return Complex(real: x.real / a, imag: x.imag / a)
}

public func / (a: Real, x: Complex) -> Complex {
    let xMagSq = x.real*x.real + x.imag*x.imag
    return Complex(real: a*x.real / xMagSq, imag: -a*x.imag / xMagSq)
}
