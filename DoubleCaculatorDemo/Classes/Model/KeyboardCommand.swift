//
//  Command.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/7.
//

import Foundation

struct Operators {
    static let reverse  = "+/-"
    static let percent  = "%"
    static let devide   = "÷"
    static let multiply = "×"
    static let plus     = "+"
    static let minus    = "-"
}

struct Digits {
    static let zero  = "0"
    static let one   = "1"
    static let two   = "2"
    static let three = "3"
    static let four  = "4"
    static let five  = "5"
    static let six   = "6"
    static let seven = "7"
    static let eight = "8"
    static let nine  = "9"
}

enum KeyboardCommand {
    case digit(Digits)
    case dot
    case operators(Operators)
    case delete
    case reset
}
