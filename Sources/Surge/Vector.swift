// Copyright © 2014-2018 the contributors
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

public struct Vector<Scalar> where Scalar: FloatingPoint, Scalar: ExpressibleByFloatLiteral {
    public let dimensions: Int

    public var scalars: [Scalar] {
        didSet {
            precondition(self.scalars.count == self.dimensions)
        }
    }

    // MARK: - Initialize

    public init(dimensions: Int, repeatedValue: Scalar) {
        let scalars = Array(repeating: repeatedValue, count: dimensions)
        self.init(scalars)
    }

    public init<T: Collection>(_ contents: T) where T.Element == Scalar {
        let scalars = Array(contents)
        self.init(scalars)
    }

    public init(_ scalars: [Scalar]) {
        self.dimensions = scalars.count
        self.scalars = scalars
    }
}

extension Vector: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Scalar...) {
        self.init(elements)
    }
}

// MARK: - Printable

extension Vector: CustomStringConvertible {
    public var description: String {
        return self.scalars.map({ "\($0)" }).joined(separator: "\t")
    }
}

// MARK: - SequenceType

extension Vector: Sequence {
    public func makeIterator() -> AnyIterator<Scalar> {
        return AnyIterator(self.scalars.makeIterator())
    }
}

// MARK: - Collection

extension Vector: Collection {
    public subscript(_ dimension: Int) -> Scalar {
        get {
            return self.scalars[dimension]
        }

        set {
            self.scalars[dimension] = newValue
        }
    }

    public var startIndex: Int {
        return self.scalars.startIndex
    }

    public var endIndex: Int {
        return self.scalars.endIndex
    }

    public func index(after i: Int) -> Int {
        return self.scalars.index(after: i)
    }
}

// MARK: - Equatable

extension Vector: Equatable {}
public func ==<T> (lhs: Vector<T>, rhs: Vector<T>) -> Bool {
    return lhs.scalars == rhs.scalars
}

// MARK: - Arithmetic

public func add(_ x: Vector<Float>, _ y: Vector<Float>) -> Vector<Float> {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with addition")

    return Vector(add(x.scalars, y.scalars))
}

public func add(_ x: Vector<Double>, _ y: Vector<Double>) -> Vector<Double> {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with addition")

    return Vector(add(x.scalars, y.scalars))
}

public func sub(_ x: Vector<Float>, _ y: Vector<Float>) -> Vector<Float> {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with subtraction")

    return Vector(sub(x.scalars, y.scalars))
}

public func sub(_ x: Vector<Double>, _ y: Vector<Double>) -> Vector<Double> {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with subtraction")

    return Vector(sub(x.scalars, y.scalars))
}

public func mul(_ x: Float, _ y: Vector<Float>) -> Vector<Float> {
    return Vector(mul(x, y.scalars))
}

public func mul(_ x: Double, _ y: Vector<Double>) -> Vector<Double> {
    return Vector(mul(x, y.scalars))
}

public func mul(_ x: Vector<Float>, _ y: Float) -> Vector<Float> {
    return Vector(mul(x.scalars, y))
}

public func mul(_ x: Vector<Double>, _ y: Double) -> Vector<Double> {
    return Vector(mul(x.scalars, y))
}

public func div(_ x: Vector<Float>, _ y: Float) -> Vector<Float> {
    return Vector(div(x.scalars, y))
}

public func div(_ x: Vector<Double>, _ y: Double) -> Vector<Double> {
    return Vector(div(x.scalars, y))
}

public func elmul(_ x: Vector<Double>, _ y: Vector<Double>) -> Vector<Double> {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with element-wise multiplication")

    return Vector(mul(x.scalars, y.scalars))
}

public func elmul(_ x: Vector<Float>, _ y: Vector<Float>) -> Vector<Float> {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with element-wise multiplication")

    return Vector(mul(x.scalars, y.scalars))
}

public func eldiv(_ x: Vector<Double>, _ y: Vector<Double>) -> Vector<Double> {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with element-wise division")

    return Vector(div(x.scalars, y.scalars))
}

public func eldiv(_ x: Vector<Float>, _ y: Vector<Float>) -> Vector<Float> {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with element-wise division")

    return Vector(div(x.scalars, y.scalars))
}

// MARK: Dot Product

public func dot(_ x: Vector<Double>, _ y: Vector<Double>) -> Double {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with dot product")

    return dot(x.scalars, y.scalars)
}

public func dot(_ x: Vector<Float>, _ y: Vector<Float>) -> Float {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with dot product")

    return dot(x.scalars, y.scalars)
}

public func pow(_ x: Vector<Double>, _ y: Double) -> Vector<Double> {
    return Vector(pow(x.scalars, y))
}

public func pow(_ x: Vector<Float>, _ y: Float) -> Vector<Float> {
    return Vector(pow(x.scalars, y))
}

public func exp(_ x: Vector<Double>) -> Vector<Double> {
    return Vector(exp(x.scalars))
}

public func exp(_ x: Vector<Float>) -> Vector<Float> {
    return Vector(exp(x.scalars))
}

// MARK: Distance

public func dist(_ x: Vector<Double>, _ y: Vector<Double>) -> Double {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with distance calculation")

    return dist(x.scalars, y.scalars)
}

public func dist(_ x: Vector<Float>, _ y: Vector<Float>) -> Float {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with distance calculation")

    return dist(x.scalars, y.scalars)
}

public func distSq(_ x: Vector<Double>, _ y: Vector<Double>) -> Double {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with distance calculation")

    return distSq(x.scalars, y.scalars)
}

public func distSq(_ x: Vector<Float>, _ y: Vector<Float>) -> Float {
    precondition(x.dimensions == y.dimensions, "Vector dimensions not compatible with distance calculation")

    return distSq(x.scalars, y.scalars)
}

// MARK: - Operators

public func + (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return add(lhs, rhs)
}

public func + (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return add(lhs, rhs)
}

public func - (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return sub(lhs, rhs)
}

public func - (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return sub(lhs, rhs)
}

public func * (lhs: Float, rhs: Vector<Float>) -> Vector<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Double, rhs: Vector<Double>) -> Vector<Double> {
    return mul(lhs, rhs)
}

public func * (lhs: Vector<Float>, rhs: Float) -> Vector<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Vector<Double>, rhs: Double) -> Vector<Double> {
    return mul(lhs, rhs)
}

public func / (lhs: Vector<Double>, rhs: Double) -> Vector<Double> {
    return div(lhs, rhs)
}

public func / (lhs: Vector<Float>, rhs: Float) -> Vector<Float> {
    return div(lhs, rhs)
}

public func .* (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return elmul(lhs, rhs)
}

public func .* (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return elmul(lhs, rhs)
}

public func ./ (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return eldiv(lhs, rhs)
}

public func ./ (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return eldiv(lhs, rhs)
}

// MARK: Dot product

infix operator •: MultiplicationPrecedence
public func • (lhs: Vector<Double>, rhs: Vector<Double>) -> Double {
    return dot(lhs, rhs)
}

public func • (lhs: Vector<Float>, rhs: Vector<Float>) -> Float {
    return dot(lhs, rhs)
}
