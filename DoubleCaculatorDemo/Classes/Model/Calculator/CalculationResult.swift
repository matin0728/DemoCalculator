//
//  CalculationResult.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/14.
//

import Foundation

extension Calculator {
    enum CalculationResult<OperandDef> where OperandDef: OperandType {
        case success(OperandDef)
        case error(ResultError)
        
        var operandValue: OperandDef {
            switch self {
            case .success(let operand):
                return operand
            case .error(_):
                return OperandDef.defaultValue
            }
        }
        
        static var defaultValue: CalculationResult {
            .success(OperandDef.defaultValue)
        }
    }
}
