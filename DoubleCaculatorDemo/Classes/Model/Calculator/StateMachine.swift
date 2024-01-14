//
//  CalculatorStateMachine.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

extension Calculator {
    /// The calculation state transfer management.
    class StateMachine<OperandDef>
        where OperandDef: OperandType {
        private(set) var lhs: OperandDef
        private(set) var rhs: OperandDef
        
        private(set) var result: CalculationResult<OperandDef> = .success(OperandDef.defaultValue)
        // private(set) var result: OperandDef = OperandDef.defaultValue
        
        private(set) lazy var currentOperator: Operator<OperandDef> = Operator<OperandDef>.nilOperator
        
        private(set) var status: Status = .waitingLhsInput
        
        lazy var historCalculate: Calculation<OperandDef> = {
            Calculation(
                lhs: OperandDef.defaultValue,
                rhs: OperandDef.defaultValue,
                result: OperandDef.defaultValue,
                operation: Operator<OperandDef>.nilOperator)
        }()
        
        init(lhs: OperandDef, rhs: OperandDef) {
            self.lhs = lhs
            self.rhs = rhs
        }
        
        func setOperator(_ theOperator: Operator<OperandDef>) {
            switch status {
            case .waitingLhsInput:
                break
            case .operatorSetup:
                break
            case .waitingRhsInput:
                // Calculate current result.
                doCalculation()
                lhs = result.operandValue /// 2 + 3 x  =>  6 x
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
                lhs = result.operandValue
                rhs = theTransformer.rhsOperand(lhs)
                currentOperator = theTransformer.resultOperator
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
            currentOperator = Operator<OperandDef>.nilOperator
            result = CalculationResult.defaultValue
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
        
        func clearErrorIfPresent() {
            if case .error(_) = result {
                result = .success(OperandDef.defaultValue)
            }
        }
        
        // MARK: - Private
        
        private func doCalculation() {
            let behaviors = CustomCalculateBehaviors()
            // get result
            do {
                result = try .success(currentOperator.operation(lhs, rhs, behaviors))
            } catch {
                if let theError = behaviors.resultError {
                    print("error: \(theError)")
                    result = .error(theError)
                }
            }
            
            // save history
            historCalculate = Calculation(lhs: lhs, rhs: rhs, result: result.operandValue, operation: currentOperator)
        }
    }

    enum Status {
        /// Inputing the first operand
        case waitingLhsInput
        /// Already has an operator
        case operatorSetup
        /// Inputing the second operand
        case waitingRhsInput
        /// Has receive the equeal command
        case resultCalculated
    }
}
