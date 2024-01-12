//
//  BaseCommandButtionView.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/12.
//

import Foundation
import UIKit

class BaseCommandButtionView: UIButton {
    let command: KeyboardCommand
    
    init(command: KeyboardCommand) {
        self.command = command
        super.init(frame: .zero)
        
        self.addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTap() {
        command.excutionCallback?(command.name)
    }
}

