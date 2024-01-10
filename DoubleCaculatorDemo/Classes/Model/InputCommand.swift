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
    /*static let four: Character  = "4"
    static let five: Character  = "5"
    static let six: Character   = "6"
    static let seven: Character = "7"
    static let eight: Character = "8"
    static let nine: Character  = "9" */
}

typealias OperatorNamed = String

enum InputCommand {
    case clear
    case delete
    case digit(Digits)
    case dot
    case operators(OperatorName)
    case reset
    case calculate
}
