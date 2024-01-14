//
//  Error.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/14.
//

import Foundation

extension Calculator {
    enum ResultError: Error, CustomStringConvertible {
        case calculationError(NSDecimalNumber.CalculationError)
        case unknown
        var description: String {
            switch self {
            case .calculationError(_):
                return "Calculation error"
            default:
                return "Unknown error"
            }
        }
    }
    
    class CustomCalculateBehaviors: NSDecimalNumberBehaviors {
        var resultError: ResultError?
        
        func roundingMode() -> NSDecimalNumber.RoundingMode {
            .bankers
        }
        
        func scale() -> Int16 {
            return 8
        }
        
        func exceptionDuringOperation(_ operation: Selector, error: NSDecimalNumber.CalculationError, leftOperand: NSDecimalNumber, rightOperand: NSDecimalNumber?) -> NSDecimalNumber? {
            resultError = .calculationError(error)
            return NSDecimalNumber.zero
        }
    }
}
