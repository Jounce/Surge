//
//  File.swift
//  
//
//  Created by Aaron Ge on 2022/6/6.
//

import XCTest

@testable import Surge

class FFTTests: XCTestCase {
    let floatAccuracy: Float = 1e-5
    let doubleAccuracy: Double = 1e-11
    
    let n: Int = 512 // Should be power of two for the FFT
    
    // MARK: - Test Arrays - Float

    let frequency: Float = 4.0
    let phase: Float = 0.0
    let amplitude: Float = 8.0
    let seconds: Float = 2.0
    let fps: Float = 512 / 2.0
    
    // MARK: - Test Arrays - Double

    let frequencyd: Double = 4.0
    let phased: Double = 0.0
    let amplituded: Double = 8.0
    let secondsd: Double = 2.0
    let fpsd: Double = 512 / 2.0


    // MARK: - FFT - Float

    func test_fft_float() {
        let sineWave = (0 ..< n).map {
            amplitude * sin(2.0 * .pi / fps * Float($0) * frequency + phase)
        }
        
        let complex:[DSPComplex] = fft(sineWave)
        var real = complex.map {$0.real}
        var imag = complex.map {$0.imag}
        
        var splitComplex = DSPSplitComplex(realp: UnsafeMutablePointer(mutating: real), imagp: UnsafeMutablePointer(mutating: imag))
        var fftMagnitudes = [Float](repeating: 0.0, count: n)
        
        vDSP_zvmags(&splitComplex, 1, &fftMagnitudes, 1, vDSP_Length(n))
        let roots = sqrt(fftMagnitudes)
        var fullSpectrum = [Float](repeating: 0.0, count: n)
        vDSP_vsmul(roots, 1, [2.0 / Float(n)], &fullSpectrum, 1, vDSP_Length(n))
        
        

        var excepted =  [Float](repeating: 0.0, count: 512)
        excepted[8] = 8.0
        excepted[504] = 8.0
        
        
//        vDSP_zvdiv(&split2, 1, &split1, 1, &split3, 1, 3)
        
//        print(split3)
        
        
        
        XCTAssertEqual(fft(sineWave), excepted, accuracy: floatAccuracy)
        XCTAssertEqual(fullSpectrum, excepted, accuracy: floatAccuracy)

    }

    // MARK: - FFT - Double
    func test_fft_double() {
        let sineWave: [Double] = (0 ..< n).map {
            amplituded * sin(2.0 * .pi / fpsd * Double($0) * frequencyd + phased)
        }
        
        let complex:[DSPDoubleComplex] = fft(sineWave)
        let real = complex.map {$0.real}
        let imag = complex.map {$0.imag}
        
        var splitComplex = DSPDoubleSplitComplex(realp: UnsafeMutablePointer(mutating: real), imagp: UnsafeMutablePointer(mutating: imag))
        
        var fftMagnitudes = [Double](repeating: 0.0, count: n)
        
        vDSP_zvmagsD(&splitComplex, 1, &fftMagnitudes, 1, vDSP_Length(n))
        let roots = sqrt(fftMagnitudes)
        var fullSpectrum = [Double](repeating: 0.0, count: n)
        vDSP_vsmulD(roots, 1, [2.0 / Double(n)], &fullSpectrum, 1, vDSP_Length(n))
        
        

        var excepted =  [Double](repeating: 0.0, count: 512)
        excepted[8] = 8.0
        excepted[504] = 8.0
        
        XCTAssertEqual(fft(sineWave), excepted, accuracy: doubleAccuracy)
        XCTAssertEqual(fullSpectrum, excepted, accuracy: doubleAccuracy)

    }

    // MARK: - IFFT - Float

    func test_ifft_float() {
        let excepted = (0 ..< n).map {
            amplitude * sin(2.0 * .pi / fps * Float($0) * frequency + phase)
        }

        let mag: [DSPComplex] = fft(excepted)

        let sineWave = ifft(mag)

        XCTAssertEqual(sineWave, excepted, accuracy: floatAccuracy)

    }
    
    func test_ifft_double() {
        let excepted = (0 ..< n).map {
            amplituded * sin(2.0 * .pi / fpsd * Double($0) * frequencyd + phased)
        }

        let mag: [DSPDoubleComplex] = fft(excepted)

        let sineWave = ifft(mag)
        
        XCTAssertEqual(sineWave, excepted, accuracy: doubleAccuracy)

    }

   
}
