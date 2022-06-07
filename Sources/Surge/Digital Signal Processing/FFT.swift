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

import Accelerate

// MARK: - Fast Fourier Transform

public func fft(_ input: [Float]) -> [Float] {
    var real = [Float](input)
    var imaginary = [Float](repeating: 0.0, count: input.count)

    return real.withUnsafeMutableBufferPointer { realBuffer in
        imaginary.withUnsafeMutableBufferPointer { imaginaryBuffer in
            var splitComplex = DSPSplitComplex(
                realp: realBuffer.baseAddress!,
                imagp: imaginaryBuffer.baseAddress!
            )

            let length = vDSP_Length(floor(log2(Float(input.count))))
            let radix = FFTRadix(kFFTRadix2)
            let weights = vDSP_create_fftsetup(length, radix)
            withUnsafeMutablePointer(to: &splitComplex) { splitComplex in
                vDSP_fft_zip(weights!, splitComplex, 1, length, FFTDirection(FFT_FORWARD))
            }

            var magnitudes = [Float](repeating: 0.0, count: input.count)
            withUnsafePointer(to: &splitComplex) { splitComplex in
                magnitudes.withUnsafeMutableBufferPointer { magnitudes in
                    vDSP_zvmags(splitComplex, 1, magnitudes.baseAddress!, 1, vDSP_Length(input.count))
                }
            }

            var normalizedMagnitudes = [Float](repeating: 0.0, count: input.count)
            normalizedMagnitudes.withUnsafeMutableBufferPointer { normalizedMagnitudes in
                vDSP_vsmul(sqrt(magnitudes), 1, [2.0 / Float(input.count)], normalizedMagnitudes.baseAddress!, 1, vDSP_Length(input.count))
            }

            vDSP_destroy_fftsetup(weights)

            return normalizedMagnitudes
        }
    }
}

public func fft(_ input: [Float]) -> [DSPComplex] {
    var real = [Float](input)
    var imaginary = [Float](repeating: 0.0, count: input.count)
    var complex =  [DSPComplex](repeating: DSPComplex(), count: input.count)

    return real.withUnsafeMutableBufferPointer { realBuffer in
        imaginary.withUnsafeMutableBufferPointer { imaginaryBuffer in
                
        
            var splitComplex = DSPSplitComplex(
                realp: realBuffer.baseAddress!,
                imagp: imaginaryBuffer.baseAddress!
            )

            let length = vDSP_Length(floor(log2(Float(input.count))))
            let radix = FFTRadix(kFFTRadix2)
            let weights = vDSP_create_fftsetup(length, radix)
            withUnsafeMutablePointer(to: &splitComplex) { splitComplex in
                vDSP_fft_zip(weights!, splitComplex, 1, length, FFTDirection(FFT_FORWARD))
            }
            
            vDSP_ztoc(&splitComplex, 1, &complex, 2, vDSP_Length(input.count))

         
            vDSP_destroy_fftsetup(weights)
            
            return complex

//            return normalizedMagnitudes
//            return
        }
    }
}

public func fft(_ input: [Double]) -> [DSPDoubleComplex] {
    var real = [Double](input)
    var imaginary = [Double](repeating: 0.0, count: input.count)
    var complex =  [DSPDoubleComplex](repeating: DSPDoubleComplex(), count: input.count)

    return real.withUnsafeMutableBufferPointer { realBuffer in
        imaginary.withUnsafeMutableBufferPointer { imaginaryBuffer in
                
        
            var splitComplex = DSPDoubleSplitComplex(
                realp: realBuffer.baseAddress!,
                imagp: imaginaryBuffer.baseAddress!
            )

            let length = vDSP_Length(floor(log2(Double(input.count))))
            let radix = FFTRadix(kFFTRadix2)
            let weights = vDSP_create_fftsetupD(length, radix)
            withUnsafeMutablePointer(to: &splitComplex) { splitComplex in
                vDSP_fft_zipD(weights!, splitComplex, 1, length, FFTDirection(FFT_FORWARD))
            }
            
            vDSP_ztocD(&splitComplex, 1, &complex, 2, vDSP_Length(input.count))

         
            vDSP_destroy_fftsetupD(weights)
            
            return complex

//            return normalizedMagnitudes
//            return
        }
    }
}

public func fft(_ input: [Double]) -> [Double] {
    var real = [Double](input)
    var imaginary = [Double](repeating: 0.0, count: input.count)

    return real.withUnsafeMutableBufferPointer { realBuffer in
        imaginary.withUnsafeMutableBufferPointer { imaginaryBuffer in
            var splitComplex = DSPDoubleSplitComplex(
                realp: realBuffer.baseAddress!,
                imagp: imaginaryBuffer.baseAddress!
            )

            let length = vDSP_Length(floor(log2(Float(input.count))))
            let radix = FFTRadix(kFFTRadix2)
            let weights = vDSP_create_fftsetupD(length, radix)
            withUnsafeMutablePointer(to: &splitComplex) { splitComplex in
                vDSP_fft_zipD(weights!, splitComplex, 1, length, FFTDirection(FFT_FORWARD))
            }

            var magnitudes = [Double](repeating: 0.0, count: input.count)
            withUnsafePointer(to: &splitComplex) { splitComplex in
                magnitudes.withUnsafeMutableBufferPointer { magnitudes in
                    vDSP_zvmagsD(splitComplex, 1, magnitudes.baseAddress!, 1, vDSP_Length(input.count))
                }
            }

            var normalizedMagnitudes = [Double](repeating: 0.0, count: input.count)
            normalizedMagnitudes.withUnsafeMutableBufferPointer { normalizedMagnitudes in
                vDSP_vsmulD(sqrt(magnitudes), 1, [2.0 / Double(input.count)], normalizedMagnitudes.baseAddress!, 1, vDSP_Length(input.count))
            }

            vDSP_destroy_fftsetupD(weights)

            return normalizedMagnitudes
        }
    }
}

// MARK: - Inverse Fast Fourier Transform
// https://github.com/christopherhelf/Swift-FFT-Example

public func ifft(_ input: [DSPComplex]) -> [Float] {
    
    //TODO: if values.count = input.count
    
    let N = input.count
    let log2N = vDSP_Length(floor(log2(Float(N))))
    
    var result: [Float] = .init(repeating: 0.0, count: N)
    
    var resultAsComplex : UnsafeMutablePointer<DSPComplex>? = nil
    var splitComplex: DSPSplitComplex = .init(realp:.allocate(capacity: N),
                                              imagp: .allocate(capacity: N))
    
    vDSP_ctoz(input, 2, &splitComplex, 1, vDSP_Length(N))
    
    let radix = FFTRadix(kFFTRadix2)
    let weights = vDSP_create_fftsetup(log2N, radix)
    
    result.withUnsafeMutableBytes {
        resultAsComplex = $0.baseAddress?.bindMemory(to: DSPComplex.self, capacity: N)
    }
    
    vDSP_fft_zip(weights!, &splitComplex, 1, log2N, FFTDirection(FFT_INVERSE))
    
    vDSP_ztoc(&splitComplex, 1, resultAsComplex!, 1, vDSP_Length(N))
    
    vDSP_destroy_fftsetup(weights)
    
    var scale: Float = 1.0 / Float(N)
    var copy = result
    vDSP_vsmul(&result, 1, &scale, &copy, 1, vDSP_Length(N))
    return copy
    
}

public func ifft(_ input: [DSPDoubleComplex]) -> [Double] {
    
    //TODO: if values.count = input.count
    
    let N = input.count
    let log2N = vDSP_Length(floor(log2(Double(N))))
    
    var result: [Double] = .init(repeating: 0.0, count: N)
    
    var resultAsComplex : UnsafeMutablePointer<DSPDoubleComplex>? = nil
    var splitComplex: DSPDoubleSplitComplex = .init(realp:.allocate(capacity: N),
                                                    imagp: .allocate(capacity: N))
    
    vDSP_ctozD(input, 2, &splitComplex, 1, vDSP_Length(N))
    
    let radix = FFTRadix(kFFTRadix2)
    let weights = vDSP_create_fftsetupD(log2N, radix)

    result.withUnsafeMutableBytes {
        resultAsComplex = $0.baseAddress?.bindMemory(to: DSPDoubleComplex.self, capacity: N)
    }
    
    vDSP_fft_zipD(weights!, &splitComplex, 1, log2N, FFTDirection(FFT_INVERSE))
    
    vDSP_ztocD(&splitComplex, 1, resultAsComplex!, 1, vDSP_Length(N))
    
    vDSP_destroy_fftsetupD(weights)
    
    var scale: Double = 1.0 / Double(N)
    var copy = result
    vDSP_vsmulD(&result, 1, &scale, &copy, 1, vDSP_Length(N))
    return copy
    
}
