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
        // Input & Output
        static let resultLabelFontSize: CGFloat = 160.0
        static let operandLabelfFontSize: CGFloat = 36.0
        static let sidePadding: CGFloat = 5.0
        // Keyboard
        static let spacing = 5.0
        static let operationButtonTransformY: CGFloat = -6
        static let operationButtonFontSize: CGFloat = 52.0
        static let defaultButtonFontSize: CGFloat = 42.0
    }
    
    private let resultLabel: UILabel = {
        let view = UILabel()
        view.text = "0"
        // view.backgroundColor = .blue
        view.textColor = .white
        view.lineBreakMode = .byClipping
        view.font = UIFont.systemFont(ofSize: Style.resultLabelFontSize, weight: .medium)
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.3
        view.textAlignment = .right
        return view
    }()
    
    private let operandLabel: UILabel = {
        let view = UILabel()
        view.text = "0"
        // view.backgroundColor = .green
        view.textColor = .white
        view.lineBreakMode = .byClipping
        view.font = UIFont.systemFont(ofSize: Style.operandLabelfFontSize, weight: .medium)
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.5
        return view
    }()
    
    private let inputWrapView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.backgroundColor = .black
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    
    let commands: [[CommandKeyViewModel]]
    
    static fileprivate var cachedButtonSize: CGSize = CGSize(width: 32, height: 32)
    
    lazy var commandViews: [UIStackView] = {
        commands.map({
            let stackView = UIStackView(arrangedSubviews: $0.map( mapCommand ))
            stackView.axis = .horizontal
            stackView.spacing = 5.0
            stackView.distribution = .fill
            
            let heightConstraint = NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: DemoCalculatorView.cachedButtonSize.height)
            NSLayoutConstraint.activate([heightConstraint])
            
            return stackView
        })
    }()
    
    init(commands: [[CommandKeyViewModel]]) {
        self.commands = commands
        
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
        DemoCalculatorView.cachedButtonSize = buttonSize
        
        let rows = commands.count
        let inputAreaHeight = CGFloat(rows) * (buttonSize.height + Style.spacing) - Style.spacing
        
        let resultSpace = (height - inputAreaHeight) * 0.75
        let resultHeight = Style.resultLabelFontSize * 1.05
        resultLabel.frame = CGRect(x: Style.sidePadding, y: resultSpace - resultHeight, width: width - Style.sidePadding, height: resultHeight)
        operandLabel.frame = CGRect(x: Style.sidePadding, y: resultLabel.frame.maxY, width: width - Style.sidePadding, height: (height - inputAreaHeight) * 0.25)
        inputWrapView.frame = CGRect(x: 0, y: operandLabel.frame.maxY, width: width, height: inputAreaHeight)
        if inputWrapView.arrangedSubviews.isEmpty {
            commandViews.forEach { view in
                self.inputWrapView.addArrangedSubview(view)
                let heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: DemoCalculatorView.cachedButtonSize.height)
                NSLayoutConstraint.activate([heightConstraint])
            }
        }
    }
    
    // MARK: - Interface
    
    func set(resultString: String, operandString: String) {
        resultLabel.text = resultString
        operandLabel.text = operandString
    }
    
    // MARK: - Private
        
    private func setupChildViews() {
        self.addSubview(resultLabel)
        self.addSubview(operandLabel)
        self.addSubview(inputWrapView)
    }
    
    private func buttonSize(_ width: CGFloat, spacing: CGFloat, columns: Int) -> CGSize {
        let theWidth = (width - CGFloat(columns - 1) * spacing) / CGFloat(columns)
        return CGSize(width: theWidth, height: theWidth * 0.8)
    }
}

fileprivate func mapCommand(_ viewModel: CommandKeyViewModel) -> DemoCalculatorCommandButtonView {
    let button = DemoCalculatorCommandButtonView(viewModel: viewModel)
    button.frame = CGRect(x: 0, y: 0, width: DemoCalculatorView.cachedButtonSize.width * CGFloat(viewModel.widthUnitRatio) + CGFloat(viewModel.widthUnitRatio - 1) * DemoCalculatorView.Style.spacing, height: DemoCalculatorView.cachedButtonSize.height)
    button.prefferedContentSize = button.frame.size
    
    let heightConstraint = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: button.prefferedContentSize.height)
    let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: button.prefferedContentSize.width)
    NSLayoutConstraint.activate([widthConstraint, heightConstraint])
    return button
}
