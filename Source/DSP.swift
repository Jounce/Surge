// Copyright © 2015 Venture Media Labs.
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

/**
    Convolution between a signal and a kernel. The signal should have at least as many elements as the kernel. The
    result will have `N - M + 1` elements where `N` is the size of the signal and `M` is the size of the kernel.
*/
public func convolution<MS: ContiguousMemory, MK: ContiguousMemory where MS.Element == Double, MK.Element == Double>(signal: MS, _ kernel: MK) -> ValueArray<Double> {
    precondition(signal.count >= kernel.count, "The signal should have at least as many elements as the kernel")

    let kernelLast = kernel.pointer + kernel.count - 1
    let resultSize = signal.count - kernel.count + 1
    let result = ValueArray<Double>(count: resultSize)
    vDSP_convD(signal.pointer, signal.step, kernelLast, -kernel.step, result.mutablePointer, result.step, vDSP_Length(resultSize), vDSP_Length(kernel.count))
    return result
}

/**
    Correlation between two vectors. The first vector should have at least as many elements as the second. The result
    will have `N - M + 1` elements where `N` is the size of the first vector and `M` is the size of the second.
*/
public func correlation<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: ML, _ rhs: MR) -> ValueArray<Double> {
    precondition(lhs.count >= rhs.count, "The first vector should have at least as many elements as the second")

    let resultSize = lhs.count - rhs.count + 1
    let result = ValueArray<Double>(count: resultSize)
    vDSP_convD(lhs.pointer, lhs.step, rhs.pointer, rhs.step, result.mutablePointer, result.step, vDSP_Length(resultSize), vDSP_Length(rhs.count))
    return result
}

/**
    Autocorrelation function. This function finds the correlation of a signal with itself shifted by increasing lags.
    Since autocorrelation is symetric, this function returns only positive lags up to the specified maximum lag. The
    maximum lag has to be smaller than the size of the signal.

    - parameter x: The signal
    - parameter maxLag: The maximum lag to use.
*/
public func autocorrelation<M: ContiguousMemory where M.Element == Double>(x: M, maxLag: Int) -> ValueArray<Double> {
    precondition(maxLag < x.count)

    let signalSize = x.count + maxLag
    let signal = ValueArray<Double>(count: signalSize, repeatedValue: 0.0)
    for i in 0..<x.count {
        signal.mutablePointer[i] = x.pointer[x.startIndex + i*x.step]
    }
    return correlation(signal, x)
}
