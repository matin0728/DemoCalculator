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
    
    // var prefferedContentSize: CGSize = .zero
    
    init(viewModel theViewModel: CommandKeyViewModel) {
        viewModel = theViewModel
        super.init(frame: .zero)
        
        setupFor(viewModel)
        
        self.addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var intrinsicContentSize: CGSize {
//        prefferedContentSize
//    }
    
    @objc func onTap() {
        viewModel.command.excutionCallback?(viewModel.command.name)
    }
    
    func setupFor(_ viewModel: CommandKeyViewModel) {
        backgroundColor = viewModel.backgroundColor
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: viewModel.transformY, leading: 0, bottom: 0, trailing: 0)
        
        let attributs = AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: viewModel.fontSize, weight: .medium),
            NSAttributedString.Key.foregroundColor: viewModel.textColor
        ])
        config.attributedTitle = AttributedString(viewModel.command.buttonText, attributes: attributs)
        self.configuration = config
    }
}
