//
//  CalculatorStateMachine.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

struct Calculation<OperandDef> {
    let lhs: OperandDef
    let rhs: OperandDef
    let result: OperandDef
    let operators: OperatorDef<OperandDef>
}

class CalculatorStateMachine<OperandDef>
    where OperandDef: OperandType {
    private(set) var lhs: OperandDef
    private(set) var rhs: OperandDef
    private(set) lazy var operators = nilOperator
    private(set) var operatorsName: OperatorName = .unknown
    private(set) var result: OperandDef = OperandDef.defaultValue
    
    private(set) var status: CalculatorStatus = .waitingLhsInput
    
    lazy var historCalculate: Calculation<OperandDef> = {
        Calculation(
            lhs: OperandDef.defaultValue,
            rhs: OperandDef.defaultValue,
            result: OperandDef.defaultValue,
            operators: nilOperator)
    }()
    
    init(lhs: OperandDef, rhs: OperandDef) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    func setOperators(_ theOperator: @escaping OperatorDef<OperandDef>, name: OperatorName) {
        operatorsName = name
        operators = theOperator
        
        switch status {
        case .waitingLhsInput:
            break
        case .operatorSetup:
            break
        case .waitingRhsInput:
            // Calculate current result.
            doCalculation()
        case .resultCalculated:
            lhs = historCalculate.result
        }
        status = .operatorSetup
    }
    
    // done!
    func acceptInput(_ input: InputCommand) {
        switch status {
        case .waitingLhsInput:
            lhs.acceptInput(input)
        case .operatorSetup:
            rhs.acceptInput(input)
            status = .waitingRhsInput
        case .waitingRhsInput:
            rhs.acceptInput(input)
        case .resultCalculated:
            rhs.acceptInput(.reset)
            rhs.acceptInput(input)
            status = .waitingRhsInput
        }
    }
    
    func calculateResult() {
        switch status {
        case .waitingLhsInput:
            rhs = lhs
            lhs = historCalculate.lhs
        case .operatorSetup:
            // use lhs as rhs
            rhs = lhs
        case .waitingRhsInput:
            break
        case .resultCalculated:
            // reuse the result and repeat calculation.
            lhs = historCalculate.result
        }
        
        doCalculation()
        status = .resultCalculated
    }
    
    func reset(_ toInitialValue: OperandDef? = nil) {
        status = .waitingLhsInput
        if let toValue = toInitialValue {
            lhs = toValue
        } else {
            lhs.acceptInput(.reset)
        }
        rhs.acceptInput(.reset)
        operators = nilOperator
        result = OperandDef.defaultValue
    }
    
    private func doCalculation() {
        result = operators(lhs, rhs)
    }
    
    private var nilOperator: OperatorDef<OperandDef> {
        { lhs, rhs in OperandDef.defaultValue }
    }
}

enum CalculatorStatus {
    /// Inputing the first operand
    case waitingLhsInput
    /// Already has an operator
    case operatorSetup
    /// Inputing the second operand
    case waitingRhsInput
    /// Has receive the equeal command
    case resultCalculated
}
