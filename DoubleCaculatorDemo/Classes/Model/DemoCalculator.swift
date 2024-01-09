//
//  DemoCalculator.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/7.
//

import Foundation


class DemoCalculator: CaculatorType {
    var result: NSDecimalNumber = .zero
    var resultOutput: String {
        result.stringValue
    }
    var operandOutput: String = ""
    
    func execCommand(_ command: KeyboardCommand) {
        switch command {
        case .delete:
            break
        case .digit(let digit):
            break
        case .dot:
            break
        case .operators(let theOperator):
            break
        case .reset:
            reset()
        }
    }
    
    func reset() {
        result = 0
        operandOutput = ""
    }
    
    typealias Command = KeyboardCommand
    typealias Result = NSDecimalNumber
    
    
}
