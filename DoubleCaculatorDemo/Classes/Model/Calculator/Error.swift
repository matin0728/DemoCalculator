//
//  Error.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/14.
//

import Foundation

extension Calculator {
    enum ResultError: Error {
        case dividingByZero
        case unknown
    }
}
