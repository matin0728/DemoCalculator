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
        return "\(statusMachine.lhs.stringValue) \(statusMachine.operatorsName.rawValue ) \(statusMachine.rhs.stringValue)"
    }
    
    let statusMachine = CalculatorStateMachine(lhs: Operand(), rhs: Operand())
    
    let supportedOperators: Operators = {
        let all = Operators()
        all.loadDefaultOperator()
        return all
    }()
    
    func execCommand(_ command: InputCommand) {
        switch command {
        case .calculate:
            statusMachine.calculateResult()
        case .delete:
            statusMachine.acceptInput(command)
        case .digit(_):
            statusMachine.acceptInput(command)
        case .dot:
            statusMachine.acceptInput(command)
        case .operators(let theOperatorName):
            guard let theOperator = supportedOperators.operatorNamed(theOperatorName) else {
                assert(false)
                return
            }
            statusMachine.setOperators(theOperator, name: theOperatorName)
        case .reset:
            statusMachine.reset()
        }
        
        onUpdate()
    }
    
    func onUpdate() {
        
    }
}
