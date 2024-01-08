//
//  DemoCalculatorApp.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/8.
//

import Foundation

/// Response for organize the two calculator
class DemoCalculatorApp {
    lazy var leftOne = DemoCalculator()
    lazy var rightOne = DemoCalculator()
    
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
    
    func execCommmand(_ command: KeyboardCommand) {
        activeOne.execCommand(command)
    }
    
    
}
