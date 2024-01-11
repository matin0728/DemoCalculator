//
//  KeyboardLayout.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/11.
//

import Foundation

struct KeyboardLayout {
    static func commands(_ excution: @escaping ((InputCommand) -> Void)) -> [[CommandKeyViewModel]] {
        let transformY = DemoCalculatorView.Style.operationButtonTransformY
        let operationFontSize = DemoCalculatorView.Style.operationButtonFontSize
        return [
            // Row 0
            [CommandKeyViewModel(
                command: .init(name: .reset,
                               buttonText: "\(InputCommand.reset)",
                               excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .operators(.reverse),
                               buttonText: OperatorName.reverse.rawValue,
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .operators(.percent),
                               buttonText: OperatorName.percent.rawValue,
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .operators(.division),
                               buttonText: OperatorName.division.rawValue,
                               excutionCallback: excution), 
                backgroundColor: .orange, fontSize: operationFontSize, transformY: transformY)],
            // Row 1
            [CommandKeyViewModel(
                command: .init(name: .digit(.seven),
                               buttonText: "\(InputCommand.digit(.seven))",
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .digit(.eight),
                               buttonText: "\(InputCommand.digit(.eight))",
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .digit(.nine),
                               buttonText: "\(InputCommand.digit(.nine))",
                               excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .operators(.multiplication),
                               buttonText: OperatorName.multiplication.rawValue,
                                excutionCallback: excution), 
                backgroundColor: .orange, fontSize: operationFontSize, transformY: transformY)],
            // Row 2
            [CommandKeyViewModel(
                command: .init(name: .digit(.four),
                               buttonText: "\(InputCommand.digit(.four))",
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .digit(.five),
                               buttonText: "\(InputCommand.digit(.five))",
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .digit(.six),
                               buttonText: "\(InputCommand.digit(.six))",
                               excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .operators(.substraction),
                               buttonText: OperatorName.substraction.rawValue,
                                excutionCallback: excution), 
                backgroundColor: .orange, fontSize: operationFontSize, transformY: transformY)],
            // Row 3
            [CommandKeyViewModel(
                command: .init(name: .digit(.one),
                               buttonText: "\(InputCommand.digit(.one))",
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .digit(.two),
                               buttonText: "\(InputCommand.digit(.two))",
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .digit(.three),
                               buttonText: "\(InputCommand.digit(.three))",
                               excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .operators(.addition),
                               buttonText: OperatorName.addition.rawValue,
                                excutionCallback: excution), 
                backgroundColor: .orange, fontSize: operationFontSize, transformY: transformY)],
            // Row 4
            [CommandKeyViewModel(
                command: .init(name: .digit(.zero),
                               buttonText: "\(InputCommand.digit(.zero))",
                                excutionCallback: excution),
                widthUnitRatio: 2),
             CommandKeyViewModel(
                command: .init(name: .dot,
                               buttonText: "\(InputCommand.dot)",
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .calculate,
                               buttonText: "\(InputCommand.calculate)",
                               excutionCallback: excution),
                backgroundColor: .orange, fontSize: operationFontSize, transformY: transformY)]
        ]
    }
}
