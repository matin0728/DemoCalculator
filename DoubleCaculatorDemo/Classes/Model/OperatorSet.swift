//
//  Operators.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

typealias DemoOperator = OperatorDef<Operand>

extension Calculator {
    /// Extensible operators, you can add new operator in the future.
    class OperatorSet {
        static let multiplication: OperandOperator = {
            OperandOperator(name: .multiplication) { lhs, rhs in
                Operand(decimalNumber: lhs.decimalValue.multiplying(by: rhs.decimalValue))
            }
        }()
        
        static let division: OperandOperator = {
            OperandOperator(name: .division) { lhs, rhs in
                Operand(decimalNumber: lhs.decimalValue.dividing(by: rhs.decimalValue))
            }
        }()
        
        static let addition: OperandOperator = {
            OperandOperator(name: .addition) { lhs, rhs in
                Operand(decimalNumber: lhs.decimalValue.adding(rhs.decimalValue))
            }
        }()
        
        static let substraction: OperandOperator = {
            OperandOperator(name: .substraction) { lhs, rhs in
                Operand(decimalNumber: lhs.decimalValue.subtracting(rhs.decimalValue))
            }
        }()
        
        static let unknown: OperandOperator = {
            OperandOperator(name: .unknown) { lhs, rhs in
                Operand(decimalNumber: NSDecimalNumber(floatLiteral: 0))
            }
        }()
        
        static func operatorNamed(_ name: OperatorName) -> OperandOperator {
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
}
