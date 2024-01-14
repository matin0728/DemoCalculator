//
//  OperatorDef.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

typealias OperatorDef<T> = (_ lhs: T, _ rhs: T) -> T

enum OperatorName: String {
    case unknown         = "N/A"
    case division        = "÷"
    case multiplication  = "×"
    case addition        = "+"
    case substraction    = "-"
}

extension Calculator {
    class Operator<T> {
        let name: OperatorName
        let operation: OperatorDef<T>
        init(name: OperatorName, operation: @escaping OperatorDef<T>) {
            self.name = name
            self.operation = operation
        }
        static var nilOperation: OperatorDef<T> {
            { lhs, _ in
                return lhs
            }
        }
        
        static var nilOperator: Operator<T> {
            Operator(name: .unknown, operation: Operator.nilOperation)
        }
    }
}
