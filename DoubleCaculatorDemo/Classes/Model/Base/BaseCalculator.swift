//
//  BaseCalculator.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/13.
//

import Foundation

struct Calculator {
}

extension Calculator {
    class Base<Command, OperandDef>: TransferableCaculatorType where OperandDef: OperandType {
        var result: OperandDef {
            statusMachine.result
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
                resultDecimalNumber = result.decimalValue
            }
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
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
                output.append(statusMachine.result.stringValue)
            }
            return output.joined(separator: " ")
        }
        
        var updateCallback: (() -> Void)?
        
        private var statusMachine = StateMachine<OperandDef>(lhs: OperandDef.defaultValue, rhs: OperandDef.defaultValue)
        
        var operaterMapper: ((OperatorName) -> Operater<OperandDef>)
        var transformerMapper: ((TransformerName) -> Transformer<OperandDef>)
        
        init(operaterMapper: @escaping ((OperatorName) -> Operater<OperandDef>), transformerMapper: @escaping ((TransformerName) -> Transformer<OperandDef>)) {
            self.operaterMapper = operaterMapper
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
                let theOperator = operaterMapper(theOperatorName)
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
        
        func transferFrom(_ caculator: Base<Command, OperandDef>) {
            statusMachine = caculator.statusMachine
            onUpdate()
        }
        
        private func onUpdate() {
            updateCallback?()
        }
    }
}
