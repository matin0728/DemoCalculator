//
//  OperatorDef.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

typealias OperatorDef<T> = (_ lhs: T, _ rhs: T) -> T

enum OperatorName: String {
    case unknown         = "N/A"
    case reverse         = "+/-"
    case percent         = "%"
    case division        = "÷"
    case multiplication  = "×"
    case addition        = "+"
    case substraction    = "-"
}

struct OperatorCategory {
    let name: String
    let operation: OperatorDef<Operand>
}
