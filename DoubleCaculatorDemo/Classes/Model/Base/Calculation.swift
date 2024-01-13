//
//  Calculation.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/11.
//

import Foundation

/// Define of calculation history record
struct Calculation<OperandDef> {
    let lhs: OperandDef
    let rhs: OperandDef
    let result: OperandDef
    let operation: Operater<OperandDef>
}
