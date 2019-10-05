// Copyright © 2014-2019 the contributors
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

    // MARK: - Initialization

    public init(dimensions: Int, repeatedValue: Scalar) {
        let scalars = Array(repeating: repeatedValue, count: dimensions)
        self.init(scalars)
    }

    public init<T>(_ contents: T) where T: Sequence, T.Element == Scalar {
        let scalars: [Scalar]
        if let array = contents as? [Scalar] {
            scalars = array
        } else {
            scalars = Array(contents)
        }
        self.dimensions = scalars.count
        self.scalars = scalars
    }

    public init(dimensions: Int, _ closure: (Int) throws -> Scalar) rethrows {
        var scalars: [Scalar] = []
        scalars.reserveCapacity(dimensions)

        for index in 0..<dimensions {
            scalars.append(try closure(index))
        }

        self.init(scalars)
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
        return self.scalars.map { "\($0)" }.joined(separator: "\t")
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
public func == <T>(lhs: Vector<T>, rhs: Vector<T>) -> Bool {
    return lhs.scalars == rhs.scalars
}

@inline(__always)
func withVector<Scalar>(from vector: Vector<Scalar>, _ closure: (inout Vector<Scalar>) -> ()) -> Vector<Scalar> {
    var copy = vector
    closure(&copy)
    return copy
}

// MARK: - Addition

public func add(_ lhs: Vector<Float>, _ rhs: Vector<Float>) -> Vector<Float> {
    return withVector(from: lhs) { addInPlace(&$0, rhs) }
}

public func add(_ lhs: Vector<Double>, _ rhs: Vector<Double>) -> Vector<Double> {
    return withVector(from: lhs) { addInPlace(&$0, rhs) }
}

public func + (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return add(lhs, rhs)
}

public func + (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return add(lhs, rhs)
}

public func add(_ lhs: Vector<Float>, _ rhs: Float) -> Vector<Float> {
    return withVector(from: lhs) { addInPlace(&$0, rhs) }
}

public func add(_ lhs: Vector<Double>, _ rhs: Double) -> Vector<Double> {
    return withVector(from: lhs) { addInPlace(&$0, rhs) }
}

public func + (lhs: Vector<Float>, rhs: Float) -> Vector<Float> {
    return add(lhs, rhs)
}

public func + (lhs: Vector<Double>, rhs: Double) -> Vector<Double> {
    return add(lhs, rhs)
}

// MARK: - Addition: In Place

func addInPlace(_ lhs: inout Vector<Float>, _ rhs: Vector<Float>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with addition")

    return eladdInPlace(&lhs.scalars, rhs.scalars)
}

func addInPlace(_ lhs: inout Vector<Double>, _ rhs: Vector<Double>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with addition")

    return eladdInPlace(&lhs.scalars, rhs.scalars)
}

public func += (lhs: inout Vector<Float>, rhs: Vector<Float>) {
    return addInPlace(&lhs, rhs)
}

public func += (lhs: inout Vector<Double>, rhs: Vector<Double>) {
    return addInPlace(&lhs, rhs)
}

func addInPlace(_ lhs: inout Vector<Float>, _ rhs: Float) {
    return addInPlace(&lhs.scalars, rhs)
}

func addInPlace(_ lhs: inout Vector<Double>, _ rhs: Double) {
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
    return withVector(from: lhs) { subInPlace(&$0, rhs) }
}

public func sub(_ lhs: Vector<Double>, _ rhs: Vector<Double>) -> Vector<Double> {
    return withVector(from: lhs) { subInPlace(&$0, rhs) }
}

public func - (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return sub(lhs, rhs)
}

public func - (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return sub(lhs, rhs)
}

public func sub(_ lhs: Vector<Float>, _ rhs: Float) -> Vector<Float> {
    return withVector(from: lhs) { subInPlace(&$0, rhs) }
}

public func sub(_ lhs: Vector<Double>, _ rhs: Double) -> Vector<Double> {
    return withVector(from: lhs) { subInPlace(&$0, rhs) }
}

public func - (lhs: Vector<Float>, rhs: Float) -> Vector<Float> {
    return sub(lhs, rhs)
}

public func - (lhs: Vector<Double>, rhs: Double) -> Vector<Double> {
    return sub(lhs, rhs)
}

// MARK: - Subtraction: In Place

func subInPlace(_ lhs: inout Vector<Float>, _ rhs: Vector<Float>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with subtraction")

    return elsubInPlace(&lhs.scalars, rhs.scalars)
}

func subInPlace(_ lhs: inout Vector<Double>, _ rhs: Vector<Double>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with subtraction")

    return elsubInPlace(&lhs.scalars, rhs.scalars)
}

public func -= (lhs: inout Vector<Float>, rhs: Vector<Float>) {
    return subInPlace(&lhs, rhs)
}

public func -= (lhs: inout Vector<Double>, rhs: Vector<Double>) {
    return subInPlace(&lhs, rhs)
}

func subInPlace(_ lhs: inout Vector<Float>, _ rhs: Float) {
    return subInPlace(&lhs.scalars, rhs)
}

func subInPlace(_ lhs: inout Vector<Double>, _ rhs: Double) {
    return subInPlace(&lhs.scalars, rhs)
}

public func -= (lhs: inout Vector<Float>, rhs: Float) {
    return subInPlace(&lhs, rhs)
}

public func -= (lhs: inout Vector<Double>, rhs: Double) {
    return subInPlace(&lhs, rhs)
}

// MARK: - Multiply Addition

public func muladd(_ lhs: Vector<Float>, _ rhs: Vector<Float>, _ alpha: Float) -> Vector<Float> {
    return withVector(from: lhs) { muladdInPlace(&$0, rhs, alpha) }
}

public func muladd(_ lhs: Vector<Double>, _ rhs: Vector<Double>, _ alpha: Double) -> Vector<Double> {
    return withVector(from: lhs) { muladdInPlace(&$0, rhs, alpha) }
}

// MARK: - Multiply Addition: In Place

func muladdInPlace(_ lhs: inout Vector<Float>, _ rhs: Vector<Float>, _ alpha: Float) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with addition")

    return elmuladdInPlace(&lhs.scalars, rhs.scalars, alpha)
}

func muladdInPlace(_ lhs: inout Vector<Double>, _ rhs: Vector<Double>, _ alpha: Double) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with addition")

    return elmuladdInPlace(&lhs.scalars, rhs.scalars, alpha)
}

// MARK: - Multiplication

public func mul(_ lhs: Vector<Float>, _ rhs: Float) -> Vector<Float> {
    return withVector(from: lhs) { mulInPlace(&$0, rhs) }
}

public func mul(_ lhs: Vector<Double>, _ rhs: Double) -> Vector<Double> {
    return withVector(from: lhs) { mulInPlace(&$0, rhs) }
}

public func * (lhs: Vector<Float>, rhs: Float) -> Vector<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Vector<Double>, rhs: Double) -> Vector<Double> {
    return mul(lhs, rhs)
}

public func mul(_ lhs: Vector<Float>, _ rhs: Matrix<Float>) -> Vector<Float> {
    // Note: `cblas_dgemv` does not seem to allow aliasing of vector `X` and `Y`.
    // As such we do not provide a `mulInPlace` variant for `vector × matrix`.

    precondition(rhs.rows == lhs.dimensions, "Matrix and vector dimensions not compatible with multiplication")
    if rhs.rows == 0 || rhs.columns == 0 || lhs.dimensions == 0 {
        return Vector<Float>(dimensions: rhs.rows, repeatedValue: 0.0)
    }

    var results = Vector<Float>(dimensions: rhs.columns, repeatedValue: 0.0)

    let rows: Int32 = numericCast(rhs.rows)
    let columns: Int32 = numericCast(rhs.columns)
    withUnsafeMutableMemory(&results.scalars) { m in
        withUnsafeMemory(lhs.scalars, rhs.grid) { lm, rm in
            cblas_sgemv(CblasRowMajor, CblasTrans, rows, columns, 1.0, rm.pointer, columns, lm.pointer, numericCast(lm.stride), 0.0, m.pointer, numericCast(m.stride))
        }
    }

    return results
}

public func mul(_ lhs: Vector<Double>, _ rhs: Matrix<Double>) -> Vector<Double> {
    // Note: `cblas_dgemv` does not seem to allow aliasing of vector `X` and `Y`.
    // As such we do not provide a `mulInPlace` variant for `vector × matrix`.

    precondition(rhs.rows == lhs.dimensions, "Matrix and vector dimensions not compatible with multiplication")
    if rhs.rows == 0 || rhs.columns == 0 || lhs.dimensions == 0 {
        return Vector<Double>(dimensions: rhs.rows, repeatedValue: 0.0)
    }

    var results = Vector<Double>(dimensions: rhs.columns, repeatedValue: 0.0)

    let rows: Int32 = numericCast(rhs.rows)
    let columns: Int32 = numericCast(rhs.columns)
    withUnsafeMutableMemory(&results.scalars) { m in
        withUnsafeMemory(lhs.scalars, rhs.grid) { lm, rm in
            cblas_dgemv(CblasRowMajor, CblasTrans, rows, columns, 1.0, rm.pointer, columns, lm.pointer, numericCast(lm.stride), 0.0, m.pointer, numericCast(m.stride))
        }
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

func mulInPlace(_ lhs: inout Vector<Float>, _ rhs: Float) {
    return mulInPlace(&lhs.scalars, rhs)
}

func mulInPlace(_ lhs: inout Vector<Double>, _ rhs: Double) {
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
    return withVector(from: lhs) { divInPlace(&$0, rhs) }
}

public func div(_ lhs: Vector<Double>, _ rhs: Double) -> Vector<Double> {
    return withVector(from: lhs) { divInPlace(&$0, rhs) }
}

public func / (lhs: Vector<Double>, rhs: Double) -> Vector<Double> {
    return div(lhs, rhs)
}

public func / (lhs: Vector<Float>, rhs: Float) -> Vector<Float> {
    return div(lhs, rhs)
}

// MARK: - Division: In Place

func divInPlace(_ lhs: inout Vector<Float>, _ rhs: Float) {
    return divInPlace(&lhs.scalars, rhs)
}

func divInPlace(_ lhs: inout Vector<Double>, _ rhs: Double) {
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
    return withVector(from: lhs) { elmulInPlace(&$0, rhs) }
}

public func elmul(_ lhs: Vector<Float>, _ rhs: Vector<Float>) -> Vector<Float> {
    return withVector(from: lhs) { elmulInPlace(&$0, rhs) }
}

public func .* (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return elmul(lhs, rhs)
}

public func .* (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return elmul(lhs, rhs)
}

// MARK: - Element-wise Multiplication: In Place

func elmulInPlace(_ lhs: inout Vector<Double>, _ rhs: Vector<Double>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise multiplication")

    return elmulInPlace(&lhs.scalars, rhs.scalars)
}

func elmulInPlace(_ lhs: inout Vector<Float>, _ rhs: Vector<Float>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise multiplication")

    return elmulInPlace(&lhs.scalars, rhs.scalars)
}

public func .*= (lhs: inout Vector<Float>, rhs: Vector<Float>) {
    return elmulInPlace(&lhs, rhs)
}

public func .*= (lhs: inout Vector<Double>, rhs: Vector<Double>) {
    return elmulInPlace(&lhs, rhs)
}

// MARK: - Element-wise Division

public func eldiv(_ lhs: Vector<Double>, _ rhs: Vector<Double>) -> Vector<Double> {
    return withVector(from: lhs) { eldivInPlace(&$0, rhs) }
}

public func eldiv(_ lhs: Vector<Float>, _ rhs: Vector<Float>) -> Vector<Float> {
    return withVector(from: lhs) { eldivInPlace(&$0, rhs) }
}

public func ./ (lhs: Vector<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return eldiv(lhs, rhs)
}

public func ./ (lhs: Vector<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return eldiv(lhs, rhs)
}

// MARK: - Element-wise Division: In Place

func eldivInPlace(_ lhs: inout Vector<Double>, _ rhs: Vector<Double>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise division")

    return eldivInPlace(&lhs.scalars, rhs.scalars)
}

func eldivInPlace(_ lhs: inout Vector<Float>, _ rhs: Vector<Float>) {
    precondition(lhs.dimensions == rhs.dimensions, "Vector dimensions not compatible with element-wise division")

    return eldivInPlace(&lhs.scalars, rhs.scalars)
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
    return withVector(from: lhs) { powInPlace(&$0, rhs) }
}

public func pow(_ lhs: Vector<Float>, _ rhs: Float) -> Vector<Float> {
    return withVector(from: lhs) { powInPlace(&$0, rhs) }
}

// MARK: - Power: In Place

func powInPlace(_ lhs: inout Vector<Double>, _ rhs: Double) {
    return powInPlace(&lhs.scalars, rhs)
}

func powInPlace(_ lhs: inout Vector<Float>, _ rhs: Float) {
    return powInPlace(&lhs.scalars, rhs)
}

// MARK: - Exponential

public func exp(_ lhs: Vector<Double>) -> Vector<Double> {
    return withVector(from: lhs) { expInPlace(&$0) }
}

public func exp(_ lhs: Vector<Float>) -> Vector<Float> {
    return withVector(from: lhs) { expInPlace(&$0) }
}

// MARK: - Exponential: In Place

func expInPlace(_ lhs: inout Vector<Double>) {
    return expInPlace(&lhs.scalars)
}

func expInPlace(_ lhs: inout Vector<Float>) {
    return expInPlace(&lhs.scalars)
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
