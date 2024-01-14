//
//  DemoCalculatorApp.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/8.
//

import Foundation

/// Response for organize the two calculator
class DemoCalculatorApp {
    lazy var leftOne = DemoCalculator { [unowned self] name in
        Calculator.OperaterSet.operaterNamed(name)
    } transformerMapper: { name in
        Calculator.OperandTransformerSet.transformerNamed(name)
    }

    lazy var rightOne = DemoCalculator{ [unowned self] name in
        Calculator.OperaterSet.operaterNamed(name)
    } transformerMapper: { name in
        Calculator.OperandTransformerSet.transformerNamed(name)
    }
    
    lazy var activeCalculator: DemoCalculator = leftOne
    
    func activeLeftOne() {
        activeCalculator = leftOne
    }
    
    func activeRightOne() {
        activeCalculator = rightOne
    }
    
    func execCommmand(_ command: InputCommand) {
        activeCalculator.execCommand(command)
    }
}
