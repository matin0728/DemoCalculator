//
//  TransformerDef.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/13.
//

import Foundation

enum TransformerName: String {
    case reverse = "+/-"
    case percent = "%"
}

typealias TransformFunc<T> = (inout T) -> Void

extension Calculator {
    /// A transformer can be applied for a operand or Result if result has been calculate, we treat it as another calculation.
    class Transformer<T> {
        let name: TransformerName
        /// When apply to lhs / rhs, using the transforming.
        let transform: TransformFunc<T>
        /// When apply to result, using the calculation simulation.
        let operater: Operater<T>
        /// Given lhs and return rsh operand
        let rhsOperand: (T) -> T
        
        init(name: TransformerName, transform: @escaping TransformFunc<T>, operater: Operater<T>, rhsOperand: @escaping (T) -> T) {
            self.name = name
            self.transform = transform
            self.operater = operater
            self.rhsOperand = rhsOperand
        }
        
        func apply( _ target: inout T) {
            transform(&target)
        }
    }
}
