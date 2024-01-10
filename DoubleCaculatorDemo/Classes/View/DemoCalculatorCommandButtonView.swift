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
    
    init(viewModel theViewModel: CommandKeyViewModel) {
        viewModel = theViewModel
        super.init(frame: .zero)
        
        setupFor(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTap() {
        viewModel.command.excutionCallback?(viewModel.command.name)
    }
    
    func setupFor(_ viewModel: CommandKeyViewModel) {
        titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        setTitle(viewModel.command.buttonText, for: .normal)
        setTitleColor(viewModel.textColor, for: .normal)
        backgroundColor = viewModel.backgroundColor
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
}
