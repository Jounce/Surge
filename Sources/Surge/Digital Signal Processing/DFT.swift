// Copyright © 2014-2022 the Surge contributors
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

// MARK: - Discrete Fourier Transform with new api
@available(macOSApplicationExtension 12.0, *)
@available(iOSApplicationExtension 15.0, *)
public func dft(_ input: [Float]) -> (real: [Float], imaginary: [Float])?{
    
    let inputReal = input
    let inputImag = [Float](repeating: 0, count: input.count)
    var outputReal = [Float](repeating: 0, count: input.count)
    var outputImag = [Float](repeating: 0, count: input.count)
    
    let log2n = floor(log2(Float(input.count)))
    let complexCount = Int(pow(Float(2), log2n))
    //
    
    
    let fwdDFT = try? vDSP.DiscreteFourierTransform(previous: nil,
                                                    count: complexCount,
                                                    direction: .forward,
                                                    transformType: .complexComplex,
                                                    ofType: Float.self)
    
    fwdDFT?.transform(inputReal: inputReal, inputImaginary: inputImag, outputReal: &outputReal, outputImaginary: &outputImag)
    
    return (outputReal, outputImag)
}

@available(macOSApplicationExtension 12.0, *)
@available(iOSApplicationExtension 15.0, *)
public func dft(_ input: [Double]) -> (real: [Double], imaginary: [Double])?{
    
    let inputReal = input
    let inputImag = [Double](repeating: 0, count: input.count)
    var outputReal = [Double](repeating: 0, count: input.count)
    var outputImag = [Double](repeating: 0, count: input.count)
    
    let log2n = floor(log2(Double(input.count)))
    let complexCount = Int(pow(Double(2), log2n))
    //
    
    
    let fwdDFT = try? vDSP.DiscreteFourierTransform(previous: nil,
                                                    count: complexCount,
                                                    direction: .forward,
                                                    transformType: .complexComplex,
                                                    ofType: Double.self)
    
    fwdDFT?.transform(inputReal: inputReal, inputImaginary: inputImag, outputReal: &outputReal, outputImaginary: &outputImag)
    
    return (outputReal, outputImag)
    
}





@available(macOSApplicationExtension 12.0, *)
@available(iOSApplicationExtension 15.0, *)
public func dft(_ input: [Float]) -> [Float]?{
    guard var complex: (real: [Float], imaginary: [Float]) = dft(input)
    else{
        return nil
    }
    var autospectrum = [Float](repeating: 0.0, count: input.count)
//    var real =  [Float](repeating: 0.0, count: input.count)
//    var imag =  [Float](repeating: 0.0, count: input.count)
//
    complex.real.withUnsafeMutableBufferPointer { realPtr in
        complex.imaginary.withUnsafeMutableBufferPointer { imagPtr in
            var frequencyDomain = DSPSplitComplex(realp: realPtr.baseAddress!,
                                                  imagp: imagPtr.baseAddress!)
//            vDSP.convert(interleavedComplexVector: complex, toSplitComplexVector: &frequencyDomain)
            vDSP_zaspec(&frequencyDomain, &autospectrum, vDSP_Length(input.count))
        }
    }
    
    return autospectrum
}

@available(macOSApplicationExtension 12.0, *)
@available(iOSApplicationExtension 15.0, *)
public func dft(_ input: [Double]) -> [Double]?{
    guard var complex:  (real: [Double], imaginary: [Double]) = dft(input)
    else{
        return nil
    }
    var autospectrum = [Double](repeating: 0.0, count: input.count)
//    var real =  [Double](repeating: 0.0, count: input.count)
//    var imag =  [Double](repeating: 0.0, count: input.count)
    
    complex.real.withUnsafeMutableBufferPointer { realPtr in
        complex.imaginary.withUnsafeMutableBufferPointer { imagPtr in
            var frequencyDomain = DSPDoubleSplitComplex(realp: realPtr.baseAddress!,
                                                  imagp: imagPtr.baseAddress!)
//            vDSP.convert(interleavedComplexVector: complex, toSplitComplexVector: &frequencyDomain)
            vDSP_zaspecD(&frequencyDomain, &autospectrum, vDSP_Length(input.count))
        }
    }
    
    return autospectrum
}


@available(macOSApplicationExtension 12.0, *)
@available(iOSApplicationExtension 15.0, *)
public func idft(_ input: (real: [Float], imaginary: [Float])) -> [Float]?{
    
//    let inputReal = input.map {$0.real}
//    let inputImag = input.map {$0.imag}
    var outputReal = [Float](repeating: 0, count: input.real.count)
    var outputImag = [Float](repeating: 0, count: input.real.count)
    
    let complexCount = input.real.count
    
    let fwdDFT = try? vDSP.DiscreteFourierTransform(previous: nil,
                                                    count: complexCount,
                                                    direction: .inverse,
                                                    transformType: .complexComplex,
                                                    ofType: Float.self)
    
    fwdDFT?.transform(inputReal: input.real, inputImaginary: input.imaginary, outputReal: &outputReal, outputImaginary: &outputImag)

    var scale : Float = 1 / Float(complexCount)
    var output = [Float](repeating: 0, count: input.real.count)
    vDSP_vsmul(&outputReal, 1, &scale, &output, 1, vDSP_Length(complexCount))
    return output
}

@available(macOSApplicationExtension 12.0, *)
@available(iOSApplicationExtension 15.0, *)
public func idft(_ input: (real: [Double], imaginary: [Double])) -> [Double]?{
    
    //    let inputReal = input.map {$0.real}
    //    let inputImag = input.map {$0.imag}
        var outputReal = [Double](repeating: 0, count: input.real.count)
        var outputImag = [Double](repeating: 0, count: input.real.count)
        
        let complexCount = input.real.count
        
        let fwdDFT = try? vDSP.DiscreteFourierTransform(previous: nil,
                                                        count: complexCount,
                                                        direction: .inverse,
                                                        transformType: .complexComplex,
                                                        ofType: Double.self)
        
        fwdDFT?.transform(inputReal: input.real, inputImaginary: input.imaginary, outputReal: &outputReal, outputImaginary: &outputImag)

        var scale : Double = 1 / Double(complexCount)
        var output = [Double](repeating: 0, count: input.real.count)
        vDSP_vsmulD(&outputReal, 1, &scale, &output, 1, vDSP_Length(complexCount))
        return output
    }
