//
//  DemoCalculatorApp.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/8.
//

import Foundation

/// Response for organize the two calculator
class DemoCalculatorApp {
    var operators: Operators {
        let all = Operators()
        all.loadDefaultOperator()
        return all
    }
    
    lazy var leftOne = DemoCalculator(operators: operators)
    lazy var rightOne = DemoCalculator(operators: operators)
    
    var isLeftOneActive = true
    
    var activeOne: DemoCalculator {
        isLeftOneActive ? leftOne : rightOne
    }
    
    func activeLeftOne() {
        isLeftOneActive = true
    }
    
    func activeRightOne() {
        isLeftOneActive = false
    }
    
    func execCommmand(_ command: InputCommand) {
        activeOne.execCommand(command)
    }
}
