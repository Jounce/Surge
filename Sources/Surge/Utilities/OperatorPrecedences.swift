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

// MARK: - Element-wise Addition

infix operator .+: AdditionPrecedence
infix operator .+=: AssignmentPrecedence

// MARK: - Element-wise Subtraction

infix operator .-: AdditionPrecedence
infix operator .-=: AssignmentPrecedence

// MARK: - Element-wise Multiplication

infix operator .*: MultiplicationPrecedence
infix operator .*=: AssignmentPrecedence

// MARK: - Element-wise Division

infix operator ./: MultiplicationPrecedence
infix operator ./=: AssignmentPrecedence

// MARK: - Element-wise Modulo

infix operator .%: MultiplicationPrecedence
infix operator .%=: AssignmentPrecedence

// MARK: - Dot product

infix operator •: MultiplicationPrecedence

// MARK: - Matrix Transpose

postfix operator ′

// MARK: - Power

precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiationPrecedence
infix operator **=: AssignmentPrecedence

// MARK: - Element-wise Power

infix operator .**: ExponentiationPrecedence
infix operator .**=: AssignmentPrecedence
