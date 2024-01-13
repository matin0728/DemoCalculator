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
        switch status {
        case .waitingLhsInput:
            break
        case .operatorSetup:
            break
        case .waitingRhsInput:
            // Calculate current result.
            doCalculation()
            lhs = result /// 2 + 3 x  =>  6 x
        case .resultCalculated:
            // doCalculation()
            lhs = historCalculate.result // 2 + 2 = x => 4 x
        }
        operatorsName = name
        operators = theOperator
        status = .operatorSetup
    }
    
    func applyTransformer(_ theTransformer: Transformer<OperandDef>) {
        switch status {
        case .waitingLhsInput:
            theTransformer.apply(&lhs)
        case .operatorSetup:
            break
        case .waitingRhsInput:
            theTransformer.apply(&rhs)
        case .resultCalculated:
            lhs = result
            rhs = theTransformer.rhsOperand(lhs)
            operatorsName = theTransformer.operater.name
            operators = theTransformer.operater.operation
            doCalculation()
        }
    }
    
    func acceptInput(_ input: InputCommand) {
        switch status {
        case .waitingLhsInput:
            lhs.acceptInput(input)
        case .operatorSetup:
            rhs.acceptInput(.reset)
            rhs.acceptInput(input)
            status = .waitingRhsInput
        case .waitingRhsInput:
            rhs.acceptInput(input)
        case .resultCalculated:
            rhs.acceptInput(.reset)
            lhs.acceptInput(.reset)
            lhs.acceptInput(input)
            status = .waitingLhsInput
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
        operatorsName = .unknown
        result = OperandDef.defaultValue
    }
    
    func clearOperand() {
        switch status {
        case .waitingLhsInput:
            lhs.acceptInput(.reset)
        case .operatorSetup:
            lhs.acceptInput(.reset)
            status = .waitingLhsInput
        case .waitingRhsInput:
            rhs.acceptInput(.reset)
        case .resultCalculated:
            reset()
        }
    }
    
    private func doCalculation() {
        // get result
        result = operators(lhs, rhs)
        // save history
        historCalculate = Calculation(lhs: lhs, rhs: rhs, result: result, operators: operators)
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
