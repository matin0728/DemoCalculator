//
//  Base.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/14.
//

import Foundation

extension Calculator {
    class BaseCalculator<Command, OperandDef>: TransferableCaculatorType where OperandDef: OperandType {
        var result: OperandDef {
            statusMachine.result.operandValue
        }
        
        var resultOutput: String {
            var resultDecimalNumber = NSDecimalNumber(floatLiteral: 0)
            switch statusMachine.status {
            case .waitingLhsInput:
                resultDecimalNumber = statusMachine.lhs.decimalValue
            case .operatorSetup:
                resultDecimalNumber = statusMachine.lhs.decimalValue
            case .waitingRhsInput:
                resultDecimalNumber = statusMachine.rhs.decimalValue
            case .resultCalculated:
                if case .error(_) = statusMachine.result {
                    return "Error"
                }
                resultDecimalNumber = result.decimalValue
            }
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 8
            
            return numberFormatter.string(from: resultDecimalNumber) ?? "0"
        }
        
        var operandOutput: String {
            var output: [String] = []
            switch statusMachine.status {
            case .waitingLhsInput:
                output.append(statusMachine.lhs.stringValue)
            case .operatorSetup:
                output.append(statusMachine.lhs.stringValue)
                output.append(statusMachine.currentOperator.name.rawValue)
            case .waitingRhsInput:
                output.append(statusMachine.lhs.stringValue)
                output.append(statusMachine.currentOperator.name.rawValue)
                output.append(statusMachine.rhs.stringValue)
            case .resultCalculated:
                output.append(statusMachine.lhs.stringValue)
                output.append(statusMachine.currentOperator.name.rawValue)
                output.append(statusMachine.rhs.stringValue)
                output.append("=")
                output.append(statusMachine.result.operandValue.stringValue)
            }
            return output.joined(separator: " ")
        }
        
        var updateCallback: (() -> Void)?
        
        private var statusMachine = StateMachine<OperandDef>(lhs: OperandDef.defaultValue, rhs: OperandDef.defaultValue)
        
        var operatorMapper: ((OperatorName) -> Operator<OperandDef>)
        var transformerMapper: ((TransformerName) -> Transformer<OperandDef>)
        
        init(operatorMapper: @escaping ((OperatorName) -> Operator<OperandDef>), transformerMapper: @escaping ((TransformerName) -> Transformer<OperandDef>)) {
            self.operatorMapper = operatorMapper
            self.transformerMapper = transformerMapper
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
                let theOperator = operatorMapper(theOperatorName)
                statusMachine.setOperator(theOperator)
            case .reset:
                statusMachine.reset()
            case .transferToRight:
                break
            case .transferLeft:
                break
            case .transformer(let theTransformerName):
                statusMachine.applyTransformer(transformerMapper(theTransformerName))
            }
            onUpdate()
        }
        
        func transferFrom(_ caculator: BaseCalculator<Command, OperandDef>) {
            statusMachine = caculator.statusMachine
            onUpdate()
        }
        
        private func onUpdate() {
            updateCallback?()
            // Clear any error exits.
            statusMachine.clearErrorIfPresent()
        }
    }
}
