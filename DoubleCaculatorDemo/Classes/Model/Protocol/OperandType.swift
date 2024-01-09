//
//  OperandType.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

protocol OperandType {
    associatedtype Input
    func acceptInput(_ input: Input)
    func reset()
}
