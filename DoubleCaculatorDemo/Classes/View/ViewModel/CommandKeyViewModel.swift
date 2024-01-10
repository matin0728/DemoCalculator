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
    let textColor: UIColor
    let backgroundColor: UIColor
    /// Default is 1, width multiplied by, WidthUnit = AvailableWidth / CommandPerline
    let widthUnitRatio: Int
    /// the height ratio multiplied by width to calculate the height of button, eg. 0.8 reslut 80% of width.
    let heightWidthRatio: CGFloat
}
