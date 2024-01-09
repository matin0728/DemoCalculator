//
//  Operators.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

typealias OperatorFunc<T> = (_ lhs: T, _ rhs: T) -> T

struct OperatorDef<T> {
    let name: String
    let command: OperatorFunc<T>
}

struct OperatorName {
    static let reverse = "+/-"
    static let percent  = "%"
    static let devide   = "÷"
    static let multiply = "×"
    static let plus     = "+"
    static let minus    = "-"
}

struct Operators {
    static let reverse  = OperatorDef<Operand>(name: OperatorName.reverse,
                                      command: { lhs, rhs in
        Operand(decimalNumber: lhs.decimalValue.multiplying(by: NSDecimalNumber(floatLiteral: -1)))
    })
}




