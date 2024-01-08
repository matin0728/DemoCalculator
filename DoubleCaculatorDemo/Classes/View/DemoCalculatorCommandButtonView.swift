//
//  DemoCalculatorCommandButtonView.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/8.
//

import Foundation
import UIKit

class DemoCalculatorCommandButtonView: UIButton {
    let command: CommandKeyViewModel
    
    init(command: CommandKeyViewModel) {
        self.command = command
        super.init(type: .custom)
        
        setupFor(command)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTap() {
        command.excutionCallback?()
    }
    
    func setupFor(_ command: CommandKeyViewModel) {
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        setTitle("AC", for: .normal)
        backgroundColor = command.backgroundColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
