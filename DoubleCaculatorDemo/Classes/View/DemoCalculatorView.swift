//
//  DemoCalculatorView.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/8.
//

import Foundation
import UIKit

/// Display a single calculator
class DemoCalculatorView: UIView {
    let resultLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let operandLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let commands: [[CommandKeyViewModel]]
    
    let commandViews: [UIStackView]
    
    init(commands: [[CommandKeyViewModel]]) {
        self.commands = commands
        self.commandViews = commands.map({
            let stackView = UIStackView(arrangedSubviews: $0.map( mapCommand ))
            stackView.axis = .horizontal
            stackView.spacing = 5.0
            return stackView
        })
        super.init(frame: .zero)
        setupChildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
        
    private func setupChildViews() {
        
    }
    
    private func buttonSize(_ width: CGFloat, spacing: CGFloat, columns: Int) -> CGSize {
        .zero
    }
}

fileprivate func mapCommand(_ viewModel: CommandKeyViewModel) -> DemoCalculatorCommandButtonView {
    return DemoCalculatorCommandButtonView(viewModel: viewModel)
}
