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
        statusMachine.result
    }
    
    var resultOutput: String {
        result.stringValue
    }
    var operandOutput: String {
        var output: [String] = []
        switch statusMachine.status {
        case .waitingLhsInput:
            output.append(statusMachine.lhs.stringValue)
        case .operatorSetup:
            output.append(statusMachine.lhs.stringValue)
            output.append(statusMachine.operatorsName.rawValue)
        case .waitingRhsInput:
            output.append(statusMachine.lhs.stringValue)
            output.append(statusMachine.operatorsName.rawValue)
            output.append(statusMachine.rhs.stringValue)
        case .resultCalculated:
            output.append(statusMachine.lhs.stringValue)
            output.append(statusMachine.operatorsName.rawValue)
            output.append(statusMachine.rhs.stringValue)
            output.append("=")
            output.append(statusMachine.result.stringValue)
        }
        return output.joined(separator: " ")
    }
    
    let statusMachine = CalculatorStateMachine(lhs: Operand(), rhs: Operand())
    
    let supportedOperators: Operators
    
    init(operators: Operators) {
        supportedOperators = operators
    }
    
    func execCommand(_ command: InputCommand) {
        switch command {
        case .calculate:
            statusMachine.calculateResult()
        case .clear:
            statusMachine.clearOperand()
        case .delete:
            statusMachine.acceptInput(command)
        case .digit(_):
            statusMachine.acceptInput(command)
        case .dot:
            statusMachine.acceptInput(command)
        case .operators(let theOperatorName):
            let theOperator = supportedOperators.operatorNamed(theOperatorName)
            statusMachine.setOperators(theOperator, name: theOperatorName)
        case .reset:
            statusMachine.reset()
        }
        onUpdate()
    }
    
    func onUpdate() {
        
    }
}
