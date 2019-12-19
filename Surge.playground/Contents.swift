// Copyright © 2014-2019 the Surge contributors
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
import PlaygroundSupport
import Surge

// MARK: - Arithmetic

let n = [-1.0, 2.0, 3.0, 4.0, 5.0]
let sum = Surge.sum(n)

let a = [1.0, 3.0, 5.0, 7.0]
let b = [2.0, 4.0, 6.0, 8.0]
let product = elmul(a, b)

// MARK: - Matrix

// ⎛ 1  1 ⎞       ⎛ 3 ⎞
// ⎢      ⎟ * B = ⎢   ⎟         B = ?
// ⎝ 1 -1 ⎠       ⎝ 1 ⎠

let A = Matrix([[1, 1], [1, -1]])
let C = Matrix([[3], [1]])
let B = inv(A) * C

// MARK: - FFT

let count = 64
let frequency = 4.0
let amplitude = 3.0

let x = (0..<count).map { 2.0 * Double.pi / Double(count) * Double($0) * frequency }

for value in sin(x) {
    value
}

for value in fft(sin(x)) {
    value
}
