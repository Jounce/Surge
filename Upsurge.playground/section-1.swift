import Foundation
import Upsurge
import XCPlayground

// MARK: - Arithmetic

let n: RealArray = [-1.0, 2.0, 3.0, 4.0, 5.0]
let sum = Upsurge.sum(n)

let a: RealArray = [1.0, 3.0, 5.0, 7.0]
let b: RealArray = [2.0, 4.0, 6.0, 8.0]
let product = a * b

// MARK: - Matrix

// ⎛ 1  1 ⎞       ⎛ 3 ⎞
// ⎢      ⎟ * B = ⎢   ⎟         C = ?
// ⎝ 1 -1 ⎠       ⎝ 1 ⎠

let A = Matrix([[1, 1], [1, -1]])
let C = Matrix([[3], [1]])
let B = inv(A) * C

// MARK: - FFT

func plot(values: RealArray, title: String) {
    for value in values {
        XCPCaptureValue(title, value: value)
    }
}

let count = 64
let frequency = 4.0
let amplitude = 1.0

let x = RealArray(array: (0..<count).map({ 2.0 * M_PI / Double(count) * Double($0) * frequency }))

plot(sin(x), title: "Sine Wave")

let fft = FFT(inputLength: x.count)
let psd = fft.forwardMags(sin(x))
plot(psd, title: "FFT")

