//
//  Operators.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

struct Operators {
    static let reverse: OperatorDef = { lhs, rhs in
        Operand(decimalNumber: lhs.decimalValue.multiplying(by: NSDecimalNumber(floatLiteral: -1)))
    }
}
