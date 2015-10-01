//  Copyright © 2015 Alejandro Isaza. All rights reserved.
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

/// Represents a closed interval in the real line
public struct Interval {
    public static let empty = Interval(min: DBL_MAX, max: DBL_MIN)

    public var min: Double
    public var max: Double

    public init() {
        min = DBL_MAX
        max = DBL_MIN
    }

    public init(min: Double, max: Double) {
        self.min = min
        self.max = max
    }

    /// Extract the minimum and maximum values from an array
    public init(values: [Double]) {
        self.init()
        for v in values {
            if v < min {
                min = v
            }
            if v > max {
                max = v
            }
        }
    }

    public func contains(value: Double) -> Bool {
        return min <= value && value <= max
    }
}

public func join(lhs: Interval, _ rhs: Interval) -> Interval {
    return Interval(min: min(lhs.min, rhs.min), max: max(lhs.max, rhs.max))
}

public func intersect(lhs: Interval, _ rhs: Interval) -> Interval {
    if lhs.max < rhs.min || rhs.max < lhs.min {
        return Interval.empty
    }
    return Interval(min: max(lhs.min, rhs.min), max: min(lhs.max, rhs.max))
}

/**
    Map a value from one interval to another. For instance mapping 0.5 from the interval [0, 1] to the iterval
    [1, 100] yields 50.
*/
func mapValue(value: Double, fromInterval: Interval, toInterval: Interval) -> Double {
    let parameter = (value - fromInterval.min) / (fromInterval.max - fromInterval.min)
    return toInterval.min + (toInterval.max - toInterval.min) * parameter
}
