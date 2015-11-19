//: ## Fast Fourier Transform
//: This example shows how to perfrom a Fast Fourier Transform with Upsurge
import Upsurge
import XCPlayground
//: Let's define a function to plot all the values in a `RealArray` to the timeline. If you don't see the timeline press ⌘⌥⏎
func plot(values: RealArray, title: String) {
    for value in values {
        XCPlaygroundPage.currentPage.captureValue(value, withIdentifier: title)
    }
}
//: Start by generating uniformly-spaced x-coordinates
let count = 64
let frequency = 4.0
let x = RealArray((0..<count).map({ 2.0 * M_PI / Real(count) * Real($0) * frequency }))

//: And the sine-wave y-coordinates
let amplitude = 1.0
let y = amplitude * sin(x)

//: Now use the function we defined previously to plot the values
plot(y, title: "Sine Wave")

//: To compute the Fast Fourier Transform we initialize the `FFT` class with the number of samples
let fft = FFT(inputLength: x.count)
//: Then compute power spectral density, which is the magnitudes of the FFT
let psd = fft.forwardMags(sin(x))
plot(psd, title: "FFT")
