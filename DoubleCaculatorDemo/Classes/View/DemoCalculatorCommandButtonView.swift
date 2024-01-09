//
//  DemoCalculatorCommandButtonView.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/8.
//

import Foundation
import UIKit

class DemoCalculatorCommandButtonView: UIButton {
    let viewModel: CommandKeyViewModel
    
    init(viewModel: CommandKeyViewModel) {
        self.viewModel = viewModel
        super.init(type: .custom)
        
        setupFor(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTap() {
        viewModel.command.excutionCallback?()
    }
    
    func setupFor(_ viewModel: CommandKeyViewModel) {
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        setTitle("AC", for: .normal)
        backgroundColor = viewModel.backgroundColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
