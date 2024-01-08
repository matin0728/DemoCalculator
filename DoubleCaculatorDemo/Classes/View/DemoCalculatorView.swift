//
//  DemoCalculatorView.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/8.
//

import Foundation
import UIKit

/// Display a single calculator
class DemoCalculatorView {
    let resultLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let operandLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let commands: [[CommandKeyViewModel]]
    
    let commandViews: [[DemoCalculatorCommandButtonView]]
    
    init(commands: [[CommandKeyViewModel]]) {
        self.commands = commands
        self.commandViews = commands.map({ $0.map( mapCommand ) })
    }
        
    func setupChildViews() {
        
    }
}

fileprivate func mapCommand(_ command: CommandKeyViewModel) -> DemoCalculatorCommandButtonView {
    return DemoCalculatorCommandButtonView(command: command)
}
