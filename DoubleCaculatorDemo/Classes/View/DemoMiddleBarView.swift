//
//  DemoMiddleBarView.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/12.
//

import Foundation
import UIKit

final class DemoMiddleBarView: UIView {
    var paddingTop: CGFloat = 0
    
    let arrowRightButton: BaseCommandButtionView
    
    let arrowLeftButton: BaseCommandButtionView
    
    let delButton: BaseCommandButtionView
    
    init(toLeftButtonCommand: KeyboardCommand, toRightCommand: KeyboardCommand, deleteCommand: KeyboardCommand) {
        arrowLeftButton = makeArrowButton(iconName: "arrowshape.left.fill", command: toLeftButtonCommand)
        arrowRightButton = makeArrowButton(iconName: "arrowshape.right.fill", command: toRightCommand)
        delButton = BaseCommandButtionView(command: deleteCommand)
        delButton.setTitle("\(InputCommand.delete)", for: .normal)
        delButton.titleLabel?.font = UIFont.systemFont(ofSize: DemoCalculatorView.Style.defaultButtonFontSize, weight: .medium)
        delButton.backgroundColor = .lightGray
        delButton.layer.cornerRadius = 16.0
        super.init(frame: .zero)
        addSubview(arrowRightButton)
        addSubview(arrowLeftButton)
        addSubview(delButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if false == self.isHidden {
            layoutButtons()
        }
    }
    
    private func layoutButtons() {
        let spacing = DemoCalculatorView.Style.spacing
        let width = self.frame.width - 6 * spacing
        let height = (self.frame.width - 2 * spacing) * 0.8
        let originX = (self.frame.width - width) / 2
        
        delButton.frame = CGRect(x: originX, y: self.frame.height - height, width: width, height: height)
        arrowLeftButton.frame = CGRect(x: originX, y: paddingTop, width: width, height: height)
        arrowRightButton.frame = CGRect(x: originX, y: arrowLeftButton.frame.maxY + 20.0, width: width, height: height)
    }
}

fileprivate func makeArrowButton(iconName: String, command: KeyboardCommand) -> BaseCommandButtionView {
    let button = BaseCommandButtionView(command: command)
    // button.tintColor = UIColor(_colorLiteralRed: 4, green: 140, blue: 76, alpha: 1)
    button.frame = .zero
    
    var config = UIButton.Configuration.plain()
    config.baseBackgroundColor = UIColor(_colorLiteralRed: 4.0 / 256.0, green: 140.0 / 256.0, blue: 76.0 / 256.0, alpha: 1.0)
    config.baseForegroundColor = .white
    config.background.backgroundColor = UIColor(_colorLiteralRed: 4.0 / 256.0, green: 140.0 / 256.0, blue: 76.0 / 256.0, alpha: 1.0)
    config.image = UIImage(systemName: iconName)
    config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: DemoCalculatorView.Style.defaultButtonFontSize - 6)
    
    button.configuration = config
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 16.0
    return button
}
