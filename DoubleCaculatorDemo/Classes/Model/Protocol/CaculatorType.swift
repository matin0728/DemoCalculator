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
    var result: Result { get }
    var resultOutput: String { get }
    /// The operands is computing
    var operandOutput: String { get }
    /// Any command pressed
    func execCommand(_ command: Command)
}

/// Transfer result to another calculator
protocol TransferableCaculatorType: CaculatorType {
    func transferFrom(_ caculator: Self)
}

// The transform behavior TBD
//extension TransferableCaculatorType {
//    mutating func transferFrom(_ caculator: Self) {
//        self.result = caculator.result
//    }
//}
