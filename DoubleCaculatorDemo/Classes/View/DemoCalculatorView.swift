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
        // Layout
        static let goddenRatio: CGFloat = 0.618
        // Input & Output
        static let resultLabelFontSize: CGFloat = 160.0
        static let operandLabelfFontSize: CGFloat = 40.0
        static let sidePadding: CGFloat = 5.0
        // Keyboard
        static let spacing = 5.0
        static let operationButtonTransformY: CGFloat = -6
        static let operationButtonFontSize: CGFloat = 52.0
        static let defaultButtonFontSize: CGFloat = 42.0
        static let buttonHeightRatio: CGFloat = 0.8
    }
    
    private let resultLabel: UILabel = {
        let view = UILabel()
        view.text = "0"
        view.textColor = .white
        view.lineBreakMode = .byClipping
        view.font = UIFont.systemFont(ofSize: Style.resultLabelFontSize, weight: .medium)
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.5
        view.textAlignment = .right
        return view
    }()
    
    private let operandLabel: UILabel = {
        let view = UILabel()
        view.text = "0"
        view.textColor = .white
        view.lineBreakMode = .byClipping
        view.font = UIFont.systemFont(ofSize: Style.operandLabelfFontSize, weight: .medium)
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.7
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
    
    private var rowHeightConstraits: [NSLayoutConstraint] = []
    private var commandButtonConstraits: [DemoCalculatorCommandButtonView : NSLayoutConstraint] = [:]
    
    let commands: [[CommandKeyViewModel]]
    
    static fileprivate var cachedButtonSize: CGSize = CGSize(width: 32, height: 32)
    
    lazy var commandViews: [UIStackView] = {
        commands.map({
            let stackView = UIStackView(arrangedSubviews: $0.map( mapCommand ))
            stackView.axis = .horizontal
            stackView.spacing = 5.0
            stackView.distribution = .fill
            stackView.alignment = .fill
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
        
        if self.isHidden { return }
        
        let width = self.frame.width
        let height = self.frame.height
        
        let buttonSize = buttonSize(self.frame.width, spacing: Style.spacing, columns: commands.first?.count ?? 1)
        DemoCalculatorView.cachedButtonSize = buttonSize
        
        let rows = commands.count
        let inputAreaHeight = DemoCalculatorView.keyboardHeight(rows: rows, buttonSize: buttonSize, padding: Style.spacing)
        
        let resultSpace = (height - inputAreaHeight) * 0.75
        let resultHeight = Style.resultLabelFontSize * 1.05
        resultLabel.frame = CGRect(x: Style.sidePadding, y: resultSpace - resultHeight, width: width - Style.sidePadding * 2, height: resultHeight)
        operandLabel.frame = CGRect(x: Style.sidePadding, y: resultLabel.frame.maxY, width: width - Style.sidePadding * 2, height: (height - inputAreaHeight) * 0.25)
        inputWrapView.frame = CGRect(x: 0, y: operandLabel.frame.maxY, width: width, height: inputAreaHeight)
        if inputWrapView.arrangedSubviews.isEmpty {
            commandViews.forEach { view in
                self.inputWrapView.addArrangedSubview(view)
                let heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: DemoCalculatorView.cachedButtonSize.height)
                self.rowHeightConstraits.append(heightConstraint)
                NSLayoutConstraint.activate([heightConstraint])
            }
        } else {
            // refresh layout
            rowHeightConstraits.forEach { cons in
                cons.constant = DemoCalculatorView.cachedButtonSize.height
            }
            commandButtonConstraits.keys.forEach { theKey in
                let viewModel = theKey.viewModel
                let width = DemoCalculatorView.cachedButtonSize.width * CGFloat(viewModel.widthUnitRatio) + CGFloat(viewModel.widthUnitRatio - 1) * DemoCalculatorView.Style.spacing
                let constraits = commandButtonConstraits[theKey]
                constraits?.constant = width
            }
        }
    }
    
    // MARK: - Interface
    
    func set(resultString: String, operandString: String) {
        resultLabel.text = resultString
        operandLabel.text = operandString
    }
    
    static func keyboardHeight(rows: Int, buttonSize: CGSize, padding: CGFloat) -> CGFloat {
        CGFloat(rows) * (buttonSize.height + Style.spacing) - padding
    }
    
    // MARK: - Private
        
    private func setupChildViews() {
        self.addSubview(resultLabel)
        self.addSubview(operandLabel)
        self.addSubview(inputWrapView)
    }
    
    private func buttonSize(_ width: CGFloat, spacing: CGFloat, columns: Int) -> CGSize {
        let theWidth = (width - CGFloat(columns - 1) * spacing) / CGFloat(columns)
        return CGSize(width: theWidth, height: theWidth * Style.buttonHeightRatio)
    }
    
    private func mapCommand(_ viewModel: CommandKeyViewModel) -> DemoCalculatorCommandButtonView {
        let button = DemoCalculatorCommandButtonView(viewModel: viewModel)
        
        let theSize = CGSize(width: DemoCalculatorView.cachedButtonSize.width * CGFloat(viewModel.widthUnitRatio) + CGFloat(viewModel.widthUnitRatio - 1) * DemoCalculatorView.Style.spacing, height: DemoCalculatorView.cachedButtonSize.height)
        
        let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: theSize.width)
        
        // Store the width constrats to cache.
        commandButtonConstraits[button] = widthConstraint
        
        NSLayoutConstraint.activate([widthConstraint])
        return button
    }

}
