//
//  Operators.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

typealias DemoOperator = OperatorDef<Operand>

/// Extensible operators, you can regist new operator in the future.
class Operators {
    private var allOperators: [OperatorName: DemoOperator] = [:]
    
    func regist(_ operators: @escaping DemoOperator, name: OperatorName) {
        allOperators[name] = operators
    }
    
    func loadDefaultOperator() {
        regist({ lhs, rhs in
            Operand(decimalNumber: lhs.decimalValue.multiplying(by: NSDecimalNumber(floatLiteral: -1)))
        }, name: OperatorName.reverse)
    }
    
    func operatorNamed(_ name: OperatorName) -> DemoOperator? {
        allOperators[name]
    }
}
