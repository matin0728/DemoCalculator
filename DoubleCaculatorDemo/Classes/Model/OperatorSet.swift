//
//  Operators.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

typealias DemoOperator = OperatorDef<Operand>

/// Extensible operators, you can add new operator in the future.
class OperaterSet {
    static let multiplication: OperandOperater = {
        OperandOperater(name: .multiplication) { lhs, rhs in
            Operand(decimalNumber: lhs.decimalValue.multiplying(by: rhs.decimalValue))
        }
    }()
    
    static let division: OperandOperater = {
        OperandOperater(name: .division) { lhs, rhs in
            Operand(decimalNumber: lhs.decimalValue.dividing(by: rhs.decimalValue))
        }
    }()
    
    static let addition: OperandOperater = {
        OperandOperater(name: .addition) { lhs, rhs in
            Operand(decimalNumber: lhs.decimalValue.adding(rhs.decimalValue))
        }
    }()
    
    static let substraction: OperandOperater = {
        OperandOperater(name: .substraction) { lhs, rhs in
            Operand(decimalNumber: lhs.decimalValue.subtracting(rhs.decimalValue))
        }
    }()
    
    static let unknown: OperandOperater = {
        OperandOperater(name: .unknown) { lhs, rhs in
            Operand(decimalNumber: NSDecimalNumber(floatLiteral: 0))
        }
    }()
    
    static func operaterNamed(_ name: OperatorName) -> OperandOperater {
        switch name {
        case .unknown:
            return unknown
        case .division:
            return division
        case .multiplication:
            return multiplication
        case .addition:
            return addition
        case .substraction:
            return substraction
        }
    }
}
