//
//  DemoCalculator.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/7.
//

import Foundation


class DemoCalculator: CaculatorType {    
    typealias Result = Operand
    typealias Command = InputCommand
    
    var result: Operand {
        statusMachine.result ?? Operand(decimalNumber: NSDecimalNumber(floatLiteral: 0))
    }
    
    var resultOutput: String {
        result.stringValue
    }
    var operandOutput: String = ""
    
    let statusMachine = CalculatorStateMachine(lhs: Operand(), rhs: Operand())
    
    func execCommand(_ command: InputCommand<Operand>) {
        switch command {
        case .delete:
            statusMachine.acceptInput(command)
        case .digit(_):
            statusMachine.acceptInput(command)
        case .dot:
            statusMachine.acceptInput(command)
        case .operators(let theOperator):
            statusMachine.setOperators(theOperator)
        case .reset:
            statusMachine.reset()
        }
    }
    
    func reset() {
        statusMachine.reset()
        operandOutput = ""
    }
}
