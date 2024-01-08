//
//  DemoCalculator.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/7.
//

import Foundation


class DemoCalculator: CaculatorType {
    var result: NSDecimalNumber = 0.0
    var resultOutput: String = ""
    var operandOutput: String = ""
    
    func execCommand(_ command: KeyboardCommand) {
        
    }
    
    func reset() {
        
    }
    
    typealias Command = KeyboardCommand
    typealias Result = NSDecimalNumber
    
    
}
