//
//  KeyboardCommand.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

struct KeyboardCommand {
    let name: String
    let buttonText: String
    let excutionCallback: (() -> Void)?
}
