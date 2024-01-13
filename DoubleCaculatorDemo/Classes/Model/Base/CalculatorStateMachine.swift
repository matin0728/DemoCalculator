//
//  CalculatorStateMachine.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

/// The calculation state transfer management.
class CalculatorStateMachine<OperandDef>
    where OperandDef: OperandType {
    private(set) var lhs: OperandDef
    private(set) var rhs: OperandDef
    
    private(set) var result: OperandDef = OperandDef.defaultValue
    
    private(set) lazy var currentOperator: Operater<OperandDef> = Operater<OperandDef>.nilOperator
    
    private(set) var status: CalculatorStatus = .waitingLhsInput
    
    lazy var historCalculate: Calculation<OperandDef> = {
        Calculation(
            lhs: OperandDef.defaultValue,
            rhs: OperandDef.defaultValue,
            result: OperandDef.defaultValue,
            operation: Operater<OperandDef>.nilOperator)
    }()
    
    init(lhs: OperandDef, rhs: OperandDef) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    func setOperator(_ theOperator: Operater<OperandDef>) {
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
        currentOperator = theOperator
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
            currentOperator = theTransformer.operater
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
        currentOperator = Operater<OperandDef>.nilOperator
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
        result = currentOperator.operation(lhs, rhs)
        // save history
        historCalculate = Calculation(lhs: lhs, rhs: rhs, result: result, operation: currentOperator)
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
