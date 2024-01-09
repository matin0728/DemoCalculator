//
//  CalculatorStateMachine.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

class CalculatorStateMachine<OperandDef>
    where OperandDef: OperandType {
    private(set) var lhs: OperandDef
    private(set) var rhs: OperandDef
    private(set) var operators: OperatorDef<OperandDef>?
    private(set) var result: OperandDef?
    
    private var status: CalculatorStatus = .waitingLhsInput
    
    init(lhs: OperandDef, rhs: OperandDef, operators: OperatorDef<OperandDef>? = nil) {
        self.lhs = lhs
        self.rhs = rhs
        self.operators = operators
    }
    
    func setOperators(_ theOperator: @escaping OperatorDef<OperandDef>) {
        switch status {
        case .waitingLhsInput:
            operators = theOperator
            status = .operatorSetup
        case .operatorSetup:
            operators = theOperator
        case .waitingRhsInput:
            // Calculate current result.
            calculateResult()
            status = .waitingRhsInput
        }
    }
    
    func acceptInput(_ input: InputCommand) {
        switch status {
        case .waitingLhsInput:
            lhs.acceptInput(input)
        case .operatorSetup:
            status = .waitingRhsInput
            rhs.acceptInput(input)
        case .waitingRhsInput:
            rhs.acceptInput(input)
        }
    }
    
    func calculateResult() {
        switch status {
        case .waitingLhsInput:
            // nothing to do
            break
        case .operatorSetup:
            rhs = lhs
            status = .waitingLhsInput
        case .waitingRhsInput:
            break
        }
        
        result = operators?(lhs, rhs)
        if let theResult = result {
            lhs = theResult
        }
        // always turn to this status.
        status = .waitingLhsInput
    }
    
    func reset(_ toInitialValue: OperandDef? = nil) {
        status = .waitingLhsInput
        if let toValue = toInitialValue {
            lhs = toValue
        } else {
            lhs.acceptInput(.reset)
        }
        rhs.acceptInput(.reset)
        operators = nil
        result = nil
    }
}

fileprivate enum CalculatorStatus {
    /// Inputing the first operand
    case waitingLhsInput
    /// Already has an operator
    case operatorSetup
    /// Inputing the second operand
    case waitingRhsInput
}
