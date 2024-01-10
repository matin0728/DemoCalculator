//
//  CommandKeyModel.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/8.
//

import Foundation
import UIKit

struct CommandKeyViewModel {
    let command: KeyboardCommand
    let backgroundColor: UIColor
    /// Default is 1, width multiplied by, WidthUnit = AvailableWidth / CommandPerline
    let widthUnitRatio: Int
    /// the height ratio multiplied by width to calculate the height of button, eg. 0.8 reslut 80% of width.
    let heightWidthRatio: CGFloat
    let textColor: UIColor
    
    init(command: KeyboardCommand, backgroundColor: UIColor = .gray, widthUnitRatio: Int = 1, heightWidthRatio: CGFloat = 0.8, textColor: UIColor = .white) {
        self.command = command
        self.backgroundColor = backgroundColor
        self.widthUnitRatio = widthUnitRatio
        self.heightWidthRatio = heightWidthRatio
        self.textColor = textColor
    }
}
