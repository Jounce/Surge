//
//  File.swift
//  
//
//  Created by Aaron Ge on 2022/6/6.
//

import XCTest
import Accelerate

@testable import Surge

@available(macOS 12.0, *)
class FFTTests: XCTestCase {
    let floatAccuracy: Float = 1e-5
    let doubleAccuracy: Double = 1e-11
    
    let n: Int = 512 // Should be power of two for the FFT
    
    // MARK: - Test Arrays - Float

    let frequency1: Float = 15
    let frequency2: Float = 20
    let phase: Float = 0.0
    let amplitude: Float = 1
//    let seconds: Float = 10
    let fps: Float = 50
    
    // MARK: - Test Arrays - Double

    let frequencyd: Double = 4.0
    let phased: Double = 0.0
    let amplituded: Double = 8.0
//    let secondsd: Double = 2.0
    let fpsd: Double = 512 / 2.0


    // MARK: - FFT - Float

    @available(macOS 12.0, *)
    @available(iOS 15.0, *)
    func test_fft_float() {

        var adft:([Float], [Float]) = dft([0,1,2,3,4,5,6,7])!
        let afft: ([Float], [Float]) = fft([0,1,2,3,4,5,6,7])
        
       
        
        var bdft: ([Float], [Float]) = dft([0.5500, 0.2167, 0.0083 , 0 , 0 , 0 , 0.0083, 0.2167])!
        let bExcepted: [Float] = [1.0000, 0.8564, 0.5333, 0.2436, 0.1333, 0.2436, 0.5333, 0.8564]
        
        var cdft = ([Float](repeating: 0, count: 8), [Float](repeating: 0, count: 8))
        
        adft.0.withUnsafeMutableBufferPointer { arealPtr in
            adft.1.withUnsafeMutableBufferPointer { aimagPtr in
                bdft.0.withUnsafeMutableBufferPointer { brealPtr in
                    bdft.1.withUnsafeMutableBufferPointer { bimagPtr in
                        cdft.0.withUnsafeMutableBufferPointer { crealPtr in
                            cdft.1.withUnsafeMutableBufferPointer { cimagPtr in
                                let aSplitComplex = DSPSplitComplex(realp: arealPtr.baseAddress!,
                                                                    imagp: aimagPtr.baseAddress!)
                                let bSplitComplex = DSPSplitComplex(realp: brealPtr.baseAddress!,
                                                                    imagp: bimagPtr.baseAddress!)
                                var cSplitComplex = DSPSplitComplex(realp: crealPtr.baseAddress!,
                                                                    imagp: cimagPtr.baseAddress!)
                                
                                vDSP.divide(aSplitComplex, by: bSplitComplex, count: 8, result: &cSplitComplex)
                            }
                        }
                    }
                }
            }
        }
        
        let cidft = idft(cdft)!
        let cifft = ifft(cdft)
        let exceptedCidft:[Float] = [-7.3980,4.2565,0.5065,3.8520,3.1480,6.4935,2.7435,14.3980]

        XCTAssertEqual(adft.0, afft.0)
        XCTAssertEqual(adft.1, afft.1)
        XCTAssertEqual(bdft.0, bExcepted, accuracy: 1e-3)
        XCTAssertEqual(cidft, exceptedCidft, accuracy: 1e-2)
        XCTAssertEqual(cifft, exceptedCidft, accuracy: 1e-2)
    }

    // MARK: - FFT - Double
//    func test_fft_double() {
//        let sineWave: [Double] = (0 ..< n).map {
//            amplituded * sin(2.0 * .pi / fpsd * Double($0) * frequencyd + phased)
//        }
//
//        let complex:[DSPDoubleComplex] = fft(sineWave)
////        let real = complex.map {$0.real}
////        let imag = complex.map {$0.imag}
//
//        var splitComplex = DSPDoubleSplitComplex(realp: .allocate(capacity: n),
//                                                 imagp: .allocate(capacity: n))
//
//        vDSP_ctozD(complex, 2, &splitComplex, 1, vDSP_Length(n))
//
//        var fftMagnitudes = [Double](repeating: 0.0, count: n)
//
//        vDSP_zvmagsD(&splitComplex, 1, &fftMagnitudes, 1, vDSP_Length(n))
//        let roots = sqrt(fftMagnitudes)
//        var fullSpectrum = [Double](repeating: 0.0, count: n)
//        vDSP_vsmulD(roots, 1, [2.0 / Double(n)], &fullSpectrum, 1, vDSP_Length(n))
//
//        let a = [Double]([1,1,1,0.49,0,0,0,0.26,0.26,0.26])
//        let f:[DSPDoubleComplex] = fft(a)
//        print(f)
//
//        var excepted =  [Double](repeating: 0.0, count: 512)
//        excepted[8] = 8.0
//        excepted[504] = 8.0
//
//        XCTAssertEqual(fft(sineWave), excepted, accuracy: doubleAccuracy)
//        XCTAssertEqual(fullSpectrum, excepted, accuracy: doubleAccuracy)
//
//    }

    // MARK: - IFFT - Float

//    func test_ifft_float() {
//        
//
//    
//        
//        let excepted = (0 ..< n).map {
//            amplitude * sin(2.0 * .pi / fps * Float($0) * frequency + phase)
//        }
//        
////        let excepted = 
//
//        let mag: [DSPComplex] = fft(excepted)
//
//        let sineWave = ifft(mag)
//
//        XCTAssertEqual(sineWave, excepted, accuracy: floatAccuracy)
//
//    }
//    
//    func test_ifft_double() {
//        let excepted = (0 ..< n).map {
//            amplituded * sin(2.0 * .pi / fpsd * Double($0) * frequencyd + phased)
//        }
//
//        let mag: [DSPDoubleComplex] = fft(excepted)
//
//        let sineWave = ifft(mag)
//
//        XCTAssertEqual(sineWave, excepted, accuracy: doubleAccuracy)
//
//    }

   
}
