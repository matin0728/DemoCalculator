//
//  InputCommand.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/7.
//

import Foundation

enum Digits: Character {
    case zero = "0"
    case one  = "1"
    case two  = "2"
    case three = "3"
    case four  = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
}

typealias OperatorNamed = String

enum InputCommand: CustomStringConvertible {
    case clear
    case delete
    case digit(Digits)
    case dot
    case operators(OperatorName)
    case reset // AC
    case calculate
    
    var description: String {
        switch self {
        case .clear:
            return "clear"
        case .delete:
            return "DEL"
        case .reset:
            return "AC"
        case .digit(let dig):
            return String([dig.rawValue])
        case .dot:
            return "."
        case .operators(let ops):
            return ops.rawValue
        case .calculate:
            return "="
        }
        return "TODO"
    }
}
