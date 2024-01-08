//
//  CaculatorType.swift
//  DoubleCaculatorDemo
//
//  Created by 马月瑶 on 2024/1/7.
//

import Foundation

/// Caculator definition
protocol CaculatorType {
    associatedtype Command
    associatedtype Result
    var result: Result { get set }
    var resultOutput: String { get }
    /// The operands is computing
    var operandOutput: String { get }
    /// Any command pressed
    func execCommand(_ command: Command)
    /// Reset the result and operand
    func reset()
}

/// Transfer result to another calculator
protocol TransferableCaculatorType: CaculatorType {
    func transferFrom(_ caculator: Self)
}

extension TransferableCaculatorType {
    mutating func transferFrom(_ caculator: Self) {
        self.result = caculator.result
    }
}
