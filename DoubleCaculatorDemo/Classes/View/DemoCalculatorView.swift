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
    struct Style {
        static let spacing = 5.0
    }
    
    let resultLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .blue
        return view
    }()
    
    let operandLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .green
        return view
    }()
    
    let inputWrapView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.backgroundColor = .gray
        return stack
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
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.width
        let height = self.frame.height
        
        let buttonSize = buttonSize(self.frame.width, spacing: Style.spacing, columns: commands.first?.count ?? 1)
        let rows = commands.count
        let inputAreaHeight = CGFloat(rows) * (buttonSize.height + Style.spacing) - Style.spacing
        
        resultLabel.frame = CGRect(x: 0, y: 0, width: width, height: (height - inputAreaHeight) * 0.75)
        operandLabel.frame = CGRect(x: 0, y: resultLabel.frame.maxY, width: width, height: (height - inputAreaHeight) * 0.25)
        inputWrapView.frame = CGRect(x: 0, y: operandLabel.frame.maxY, width: width, height: inputAreaHeight)
    }
        
    private func setupChildViews() {
        commandViews.forEach { view in
            self.inputWrapView.addArrangedSubview(view)
        }
    }
    
    private func buttonSize(_ width: CGFloat, spacing: CGFloat, columns: Int) -> CGSize {
        .zero
    }
}

fileprivate func mapCommand(_ viewModel: CommandKeyViewModel) -> DemoCalculatorCommandButtonView {
    return DemoCalculatorCommandButtonView(viewModel: viewModel)
}
