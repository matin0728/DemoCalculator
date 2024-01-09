//
//  OperatorDef.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

typealias OperatorDef<T> = (_ lhs: T, _ rhs: T) -> T

//struct OperatorDef<T> {
//    let name: String
//    let command: OperatorFunc<T>
//}

struct OperatorName {
    static let reverse = "+/-"
    static let percent  = "%"
    static let devide   = "÷"
    static let multiply = "×"
    static let plus     = "+"
    static let minus    = "-"
}
