import Foundation
import Surge
import PlaygroundSupport

// MARK: - Arithmetic

let n = [-1.0, 2.0, 3.0, 4.0, 5.0]
let sum = Surge.sum(n)

let a = [1.0, 3.0, 5.0, 7.0]
let b = [2.0, 4.0, 6.0, 8.0]
let product = Surge.mul(a, y: b)

// MARK: - Matrix

// ⎛ 1  1 ⎞       ⎛ 3 ⎞
// ⎢      ⎟ * B = ⎢   ⎟         C = ?
// ⎝ 1 -1 ⎠       ⎝ 1 ⎠

let A = Matrix([[1, 1], [1, -1]])
let C = Matrix([[3], [1]])
let B = inv(A) * C

// MARK: - FFT

let count = 64
let frequency = 4.0
let amplitude = 3.0

let x = (0..<count).map{ 2.0 * Double.pi / Double(count) * Double($0) * frequency }

for value in sin(x) {
    value
}

for value in fft(sin(x)) {
    value
}
