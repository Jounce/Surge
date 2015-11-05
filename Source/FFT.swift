// Copyright (c) 2014–2015 Mattt Thompson (http://mattt.me)
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

public class FFT {
    private var lengthLog2: vDSP_Length
    private var setup: FFTSetupD
    public private(set) var length: vDSP_Length

    private let real: ValueArray<Double>
    private let imag: ValueArray<Double>

    public init(inputLength: Int) {
        lengthLog2 = vDSP_Length(ceil(log2(Real(inputLength))))
        length = vDSP_Length(exp2(Real(lengthLog2)))
        setup = vDSP_create_fftsetupD(lengthLog2, FFTRadix(kFFTRadix2))

        real = ValueArray<Double>(count: Int(length))
        imag = ValueArray<Double>(count: Int(length))
    }

    deinit {
        vDSP_destroy_fftsetupD(setup)
    }

    /// Performs a real to complex forward FFT
    public func forward<M: ContiguousMemory where M.Element == Double>(input: M) -> ComplexArray {
        precondition(input.count == Int(length), "Input should have \(length) elements")

        real.mutablePointer.assignFrom(UnsafeMutablePointer<Double>(input.pointer), count: Int(length))
        for i in 0..<Int(length) {
            imag.mutablePointer[i] = 0.0
        }

        var splitComplex = DSPDoubleSplitComplex(realp: real.mutablePointer, imagp: imag.mutablePointer)
        vDSP_fft_zipD(setup, &splitComplex, 1, lengthLog2, FFTDirection(FFT_FORWARD))

        let result = ComplexArray(count: Int(length/2))
        vDSP_ztocD(&splitComplex, 1, UnsafeMutablePointer<DSPDoubleComplex>(result.mutablePointer), 1, length/2)

        let scale = 2.0 / Real(length)
        return result * scale * scale
    }

    /// Performs a real to real forward FFT by taking the square magnitudes of the complex result
    public func forwardMags<M: ContiguousMemory where M.Element == Double>(input: M) -> ValueArray<Double> {
        precondition(input.count == Int(length), "Input should have \(length) elements")

        real.mutablePointer.assignFrom(UnsafeMutablePointer<Double>(input.pointer), count: Int(length))
        for i in 0..<Int(length) {
            imag.mutablePointer[i] = 0.0
        }

        var splitComplex = DSPDoubleSplitComplex(realp: real.mutablePointer, imagp: imag.mutablePointer)
        vDSP_fft_zipD(setup, &splitComplex, 1, lengthLog2, FFTDirection(FFT_FORWARD))

        let magnitudes = ValueArray<Double>(count: Int(length/2))
        vDSP_zvmagsD(&splitComplex, 1, magnitudes.mutablePointer, 1, length/2)

        let scale = 2.0 / Real(length)
        return magnitudes * scale * scale
    }
}
