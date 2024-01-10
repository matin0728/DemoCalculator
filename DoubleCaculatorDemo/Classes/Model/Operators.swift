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
        
        regist({ lhs, rhs in
            Operand(decimalNumber: lhs.decimalValue.adding(rhs.decimalValue.multiplying(by: NSDecimalNumber(floatLiteral: -1))))
        }, name: OperatorName.plus)
        
        regist({ lhs, rhs in
            Operand(decimalNumber: lhs.decimalValue.adding(rhs.decimalValue))
        }, name: OperatorName.minus)
        
        regist({ lhs, rhs in
            Operand(decimalNumber: lhs.decimalValue.multiplying(by: rhs.decimalValue))
        }, name: OperatorName.multiply)
        
        regist({ lhs, rhs in
            Operand(decimalNumber: lhs.decimalValue.dividing(by: rhs.decimalValue))
        }, name: OperatorName.devide)
        
        regist({ lhs, rhs in
            Operand(decimalNumber: lhs.decimalValue.adding(rhs.decimalValue.multiplying(by: NSDecimalNumber(floatLiteral: 100))))
        }, name: OperatorName.percent)
    }
    
    func operatorNamed(_ name: OperatorName) -> DemoOperator {
        allOperators[name] ?? nilOperator
    }
    
    private var nilOperator: DemoOperator {
        return { lhs, rhs in
            Operand()
        }
    }
}
