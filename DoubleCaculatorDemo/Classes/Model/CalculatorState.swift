//
//  CalculatorState.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

class CalculatorState {
    var lhs: Operand
    var rhs: Operand
    var operators: Operators
    
    init(lhs: Operand, rhs: Operand, operators: Operators) {
        self.lhs = lhs
        self.rhs = rhs
        self.operators = operators
    }
}
