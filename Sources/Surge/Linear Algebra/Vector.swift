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

    public init<T: Sequence>(_ contents: T) where T.Element == Scalar {
        let scalars: [Scalar]
        if let array = contents as? [Scalar] {
            scalars = array
        } else {
            scalars = Array(contents)
        }
        self.dimensions = scalars.count
        self.scalars = scalars
    }
}

// MARK: - ExpressibleByArrayLiteral

extension Vector: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Scalar...) {
        self.init(elements)
    }
}

// MARK: - CustomStringConvertible

extension Vector: CustomStringConvertible {
    public var description: String {
        return self.scalars.map({ "\($0)" }).joined(separator: "\t")
    }
}

// MARK: - Sequence

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

// MARK: - Addition

public func add(_ lhs: Vector<Float>, _ rhs: Vector<Float>) -> Vector<Float> {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with addition")

    return Vector(add(lhs.scalars, rhs.scalars))
}

public func add(_ lhs: Vector<Double>, _ rhs: Vector<Double>) -> Vector<Double> {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with addition")

    return Vector(add(lhs.scalars, rhs.scalars))
}

public func + (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return add(lhs, rhs)
}

public func + (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return add(lhs, rhs)
}

public func add(_ lhs: Vector<Float>, _ rhs: Float) -> Vector<Float> {
    return Vector(add(lhs.scalars, rhs))
}

public func add(_ lhs: Vector<Double>, _ rhs: Double) -> Vector<Double> {
    return Vector(add(lhs.scalars, rhs))
}

public func + (lhs: Vector<Float>, rhs: Float) -> Vector<Float> {
    return add(lhs, rhs)
}

public func + (lhs: Vector<Double>, rhs: Double) -> Vector<Double> {
    return add(lhs, rhs)
}

// MARK: - Addition: In Place

public func addInPlace(_ lhs: inout Vector<Float>, _ rhs: Vector<Float>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with addition")

    return addInPlace(&lhs.scalars, rhs.scalars)
}

public func addInPlace(_ lhs: inout Vector<Double>, _ rhs: Vector<Double>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with addition")

    return addInPlace(&lhs.scalars, rhs.scalars)
}

public func += (lhs: inout Vector<Float>, rhs: Vector<Float>) {
    return addInPlace(&lhs, rhs)
}

public func += (lhs: inout Vector<Double>, rhs: Vector<Double>) {
    return addInPlace(&lhs, rhs)
}

public func addInPlace(_ lhs: inout Vector<Float>, _ rhs: Float) {
    return addInPlace(&lhs.scalars, rhs)
}

public func addInPlace(_ lhs: inout Vector<Double>, _ rhs: Double) {
    return addInPlace(&lhs.scalars, rhs)
}

public func += (lhs: inout Vector<Float>, rhs: Float) {
    return addInPlace(&lhs, rhs)
}

public func += (lhs: inout Vector<Double>, rhs: Double) {
    return addInPlace(&lhs, rhs)
}

// MARK: - Subtraction

public func sub(_ lhs: Vector<Float>, _ rhs: Vector<Float>) -> Vector<Float> {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with subtraction")

    return Vector(sub(lhs.scalars, rhs.scalars))
}

public func sub(_ lhs: Vector<Double>, _ rhs: Vector<Double>) -> Vector<Double> {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with subtraction")

    return Vector(sub(lhs.scalars, rhs.scalars))
}

public func - (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return sub(lhs, rhs)
}

public func - (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return sub(lhs, rhs)
}

public func sub(_ lhs: Vector<Float>, _ rhs: Float) -> Vector<Float> {
    return Vector(sub(lhs.scalars, rhs))
}

public func sub(_ lhs: Vector<Double>, _ rhs: Double) -> Vector<Double> {
    return Vector(sub(lhs.scalars, rhs))
}

public func - (lhs: Vector<Float>, rhs: Float) -> Vector<Float> {
    return sub(lhs, rhs)
}

public func - (lhs: Vector<Double>, rhs: Double) -> Vector<Double> {
    return sub(lhs, rhs)
}

// MARK: - Subtraction: In Place

public func subInPlace(_ lhs: inout Vector<Float>, _ rhs: Vector<Float>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with subtraction")

    return subInPlace(&lhs.scalars, rhs.scalars)
}

public func subInPlace(_ lhs: inout Vector<Double>, _ rhs: Vector<Double>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with subtraction")

    return subInPlace(&lhs.scalars, rhs.scalars)
}

public func -= (lhs: inout Vector<Float>, rhs: Vector<Float>) {
    return subInPlace(&lhs, rhs)
}

public func -= (lhs: inout Vector<Double>, rhs: Vector<Double>) {
    return subInPlace(&lhs, rhs)
}

public func subInPlace(_ lhs: inout Vector<Float>, _ rhs: Float) {
    return subInPlace(&lhs.scalars, rhs)
}

public func subInPlace(_ lhs: inout Vector<Double>, _ rhs: Double) {
    return subInPlace(&lhs.scalars, rhs)
}

public func -= (lhs: inout Vector<Float>, rhs: Float) {
    return subInPlace(&lhs, rhs)
}

public func -= (lhs: inout Vector<Double>, rhs: Double) {
    return subInPlace(&lhs, rhs)
}

// MARK: - Multiplication

public func mul(_ lhs: Vector<Float>, _ rhs: Float) -> Vector<Float> {
    return Vector(mul(lhs.scalars, rhs))
}

public func mul(_ lhs: Vector<Double>, _ rhs: Double) -> Vector<Double> {
    return Vector(mul(lhs.scalars, rhs))
}

public func * (lhs: Vector<Float>, rhs: Float) -> Vector<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Vector<Double>, rhs: Double) -> Vector<Double> {
    return mul(lhs, rhs)
}

public func mul(_ lhs: Vector<Float>, _ rhs: Matrix<Float>) -> Vector<Float> {
    precondition(rhs.rows == lhs.dimensions, "Matrix and vector dimensions not compatible with multiplication")
    if rhs.rows == 0 || rhs.columns == 0 || lhs.dimensions == 0 {
        return Vector<Float>(dimensions: rhs.rows, repeatedValue: 0.0)
    }

    var results = Vector<Float>(dimensions: rhs.columns, repeatedValue: 0.0)
    results.scalars.withUnsafeMutableBufferPointer { pointer in
        cblas_sgemv(CblasRowMajor, CblasTrans, Int32(rhs.rows), Int32(rhs.columns), 1.0, rhs.grid, Int32(rhs.columns), lhs.scalars, 1, 0.0, pointer.baseAddress!, 1)
    }

    return results
}

public func mul(_ lhs: Vector<Double>, _ rhs: Matrix<Double>) -> Vector<Double> {
    precondition(rhs.rows == lhs.dimensions, "Matrix and vector dimensions not compatible with multiplication")
    if rhs.rows == 0 || rhs.columns == 0 || lhs.dimensions == 0 {
        return Vector<Double>(dimensions: rhs.rows, repeatedValue: 0.0)
    }

    var results = Vector<Double>(dimensions: rhs.columns, repeatedValue: 0.0)
    results.scalars.withUnsafeMutableBufferPointer { pointer in
        cblas_dgemv(CblasRowMajor, CblasTrans, Int32(rhs.rows), Int32(rhs.columns), 1.0, rhs.grid, Int32(rhs.columns), lhs.scalars, 1, 0.0, pointer.baseAddress!, 1)
    }

    return results
}

public func * (lhs: Vector<Float>, rhs: Matrix<Float>) -> Vector<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Vector<Double>, rhs: Matrix<Double>) -> Vector<Double> {
    return mul(lhs, rhs)
}

// MARK: - Multiplication: In Place

public func mulInPlace(_ lhs: inout Vector<Float>, _ rhs: Float) {
    return mulInPlace(&lhs.scalars, rhs)
}

public func mulInPlace(_ lhs: inout Vector<Double>, _ rhs: Double) {
    return mulInPlace(&lhs.scalars, rhs)
}

public func *= (lhs: inout Vector<Float>, rhs: Float) {
    return mulInPlace(&lhs, rhs)
}

public func *= (lhs: inout Vector<Double>, rhs: Double) {
    return mulInPlace(&lhs, rhs)
}

// MARK: - Division

public func div(_ lhs: Vector<Float>, _ rhs: Float) -> Vector<Float> {
    return Vector(div(lhs.scalars, rhs))
}

public func div(_ lhs: Vector<Double>, _ rhs: Double) -> Vector<Double> {
    return Vector(div(lhs.scalars, rhs))
}

public func / (lhs: Vector<Double>, rhs: Double) -> Vector<Double> {
    return div(lhs, rhs)
}

public func / (lhs: Vector<Float>, rhs: Float) -> Vector<Float> {
    return div(lhs, rhs)
}

// MARK: - Division: In Place

public func divInPlace(_ lhs: inout Vector<Float>, _ rhs: Float) {
    return divInPlace(&lhs.scalars, rhs)
}

public func divInPlace(_ lhs: inout Vector<Double>, _ rhs: Double) {
    return divInPlace(&lhs.scalars, rhs)
}

public func /= (lhs: inout Vector<Float>, rhs: Float) {
    return divInPlace(&lhs, rhs)
}

public func /= (lhs: inout Vector<Double>, rhs: Double) {
    return divInPlace(&lhs, rhs)
}

// MARK: - Element-wise Multiplication

public func elmul(_ lhs: Vector<Double>, _ rhs: Vector<Double>) -> Vector<Double> {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise multiplication")

    return Vector(mul(lhs.scalars, rhs.scalars))
}

public func elmul(_ lhs: Vector<Float>, _ rhs: Vector<Float>) -> Vector<Float> {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise multiplication")

    return Vector(mul(lhs.scalars, rhs.scalars))
}

public func .* (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return elmul(lhs, rhs)
}

public func .* (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return elmul(lhs, rhs)
}

// MARK: - Element-wise Multiplication: In Place

public func elmulInPlace(_ lhs: inout Vector<Double>, _ rhs: Vector<Double>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise multiplication")

    return mulInPlace(&lhs.scalars, rhs.scalars)
}

public func elmulInPlace(_ lhs: inout Vector<Float>, _ rhs: Vector<Float>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise multiplication")

    return mulInPlace(&lhs.scalars, rhs.scalars)
}

public func .*= (lhs: inout Vector<Float>, rhs: Vector<Float>) {
    return elmulInPlace(&lhs, rhs)
}

public func .*= (lhs: inout Vector<Double>, rhs: Vector<Double>) {
    return elmulInPlace(&lhs, rhs)
}

// MARK: - Element-wise Division

public func eldiv(_ lhs: Vector<Double>, _ rhs: Vector<Double>) -> Vector<Double> {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise division")

    return Vector(div(lhs.scalars, rhs.scalars))
}

public func eldiv(_ lhs: Vector<Float>, _ rhs: Vector<Float>) -> Vector<Float> {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise division")

    return Vector(div(lhs.scalars, rhs.scalars))
}

public func ./ (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return eldiv(lhs, rhs)
}

public func ./ (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return eldiv(lhs, rhs)
}

// MARK: - Element-wise Division: In Place

public func eldivInPlace(_ lhs: inout Vector<Double>, _ rhs: Vector<Double>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise division")

    return divInPlace(&lhs.scalars, rhs.scalars)
}

public func eldivInPlace(_ lhs: inout Vector<Float>, _ rhs: Vector<Float>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise division")

    return divInPlace(&lhs.scalars, rhs.scalars)
}

public func ./= (lhs: inout Vector<Double>, rhs: Vector<Double>) {
    return eldivInPlace(&lhs, rhs)
}

public func ./= (lhs: inout Vector<Float>, rhs: Vector<Float>) {
    return eldivInPlace(&lhs, rhs)
}

// MARK: - Dot Product

public func dot(_ lhs: Vector<Double>, _ rhs: Vector<Double>) -> Double {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with dot product")

    return dot(lhs.scalars, rhs.scalars)
}

public func dot(_ lhs: Vector<Float>, _ rhs: Vector<Float>) -> Float {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with dot product")

    return dot(lhs.scalars, rhs.scalars)
}

infix operator •: MultiplicationPrecedence
public func • (lhs: Vector<Double>, rhs: Vector<Double>) -> Double {
    return dot(lhs, rhs)
}

public func • (lhs: Vector<Float>, rhs: Vector<Float>) -> Float {
    return dot(lhs, rhs)
}

// MARK: - Power

public func pow(_ lhs: Vector<Double>, _ rhs: Double) -> Vector<Double> {
    return Vector(pow(lhs.scalars, rhs))
}

public func pow(_ lhs: Vector<Float>, _ rhs: Float) -> Vector<Float> {
    return Vector(pow(lhs.scalars, rhs))
}

// MARK: - Exponential

public func exp(_ lhs: Vector<Double>) -> Vector<Double> {
    return Vector(exp(lhs.scalars))
}

public func exp(_ lhs: Vector<Float>) -> Vector<Float> {
    return Vector(exp(lhs.scalars))
}

// MARK: - Distance

public func dist(_ lhs: Vector<Double>, _ rhs: Vector<Double>) -> Double {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with distance calculation")

    return dist(lhs.scalars, rhs.scalars)
}

public func dist(_ lhs: Vector<Float>, _ rhs: Vector<Float>) -> Float {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with distance calculation")

    return dist(lhs.scalars, rhs.scalars)
}

// MARK: - Distance Squared

public func distSq(_ lhs: Vector<Double>, _ rhs: Vector<Double>) -> Double {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with distance calculation")

    return distSq(lhs.scalars, rhs.scalars)
}

public func distSq(_ lhs: Vector<Float>, _ rhs: Vector<Float>) -> Float {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with distance calculation")

    return distSq(lhs.scalars, rhs.scalars)
}
