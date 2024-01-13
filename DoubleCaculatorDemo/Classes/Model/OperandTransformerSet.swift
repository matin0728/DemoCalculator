//
//  OperandTransformer.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/13.
//

import Foundation

/// Predefined transformers.
struct OperandTransformerSet {
    static let revers: OperandTransformer = {
        OperandTransformer(
            name: .reverse, transform: { operand in
            if operand.isMutable {
                operand.isNagative = !operand.isNagative
            } else {
                operand = Operand(decimalNumber: operand.decimalValue.multiplying(by: NSDecimalNumber(floatLiteral: -1)))
            }
        }, 
            operater: OperaterSet.multiplication,
            rhsOperand: { _ in
                Operand(decimalNumber: NSDecimalNumber(floatLiteral: -1))
            })
    }()
    
    static let percent: OperandTransformer = {
        OperandTransformer(name: .percent, transform: { operand in
            operand = Operand(decimalNumber: operand.decimalValue.multiplying(by: NSDecimalNumber(floatLiteral: 0.01)))
        }, operater: OperaterSet.multiplication) { _ in
            Operand(decimalNumber: NSDecimalNumber(floatLiteral: 0.01))
        }
    }()
    
    static func transformerNamed(_ name: TransformerName) -> OperandTransformer {
        switch name {
        case .reverse:
            return OperandTransformerSet.revers
        case .percent:
            return OperandTransformerSet.percent
        }
    }
}
