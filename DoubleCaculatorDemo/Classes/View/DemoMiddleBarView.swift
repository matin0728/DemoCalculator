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
        arrowLeftButton = makeArrowButton(iconName: "arrowshape.left", command: toLeftButtonCommand)
        arrowRightButton = makeArrowButton(iconName: "arrowshape.left", command: toRightCommand)
        delButton = BaseCommandButtionView(command: deleteCommand)
        delButton.setTitle("DEL", for: .normal)
        delButton.backgroundColor = .lightGray
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
        
        layoutButtons()
    }
    
    private func layoutButtons() {
        let spacing = DemoCalculatorView.Style.spacing
        let width = self.frame.width - 2 * spacing
        
        delButton.frame = CGRect(x: spacing, y: self.frame.height - width, width: width, height: width)
        arrowLeftButton.frame = CGRect(x: spacing, y: paddingTop, width: width, height: width)
        arrowRightButton.frame = CGRect(x: spacing, y: arrowLeftButton.frame.maxY + 20.0, width: width, height: width)
    }
}

fileprivate func makeArrowButton(iconName: String, command: KeyboardCommand) -> BaseCommandButtionView {
    let button = BaseCommandButtionView(command: command)
    button.backgroundColor = UIColor(_colorLiteralRed: 4, green: 140, blue: 76, alpha: 1)
    button.frame = .zero
    button.setImage(UIImage(systemName: iconName)?.withTintColor(.white), for: .normal)
    return button
}
