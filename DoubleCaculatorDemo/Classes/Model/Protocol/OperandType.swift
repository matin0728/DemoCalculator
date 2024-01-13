//
//  OperandType.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

protocol OperandType {
    func acceptInput(_ input: InputCommand)
    var stringValue: String { get }
    var decimalValue: NSDecimalNumber { get }
    static var defaultValue: Self { get }
}
