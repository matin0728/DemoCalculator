//
//  DemoCalculatorContainerView.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/11.
//

import Foundation
import UIKit

/// The conainer for display two calculator at the same time.
final class DemoCalculatorContainerView: UIView {
    let leftOneView: UIView
    let middleBarView: UIView
    let rightOneView: UIView
    
    var activeOne: UIView
    
    private lazy var layoutStack: UIView = {
        let view = UIView()
        view.addSubview(leftOneView)
        view.addSubview(middleBarView)
        view.addSubview(rightOneView)
        return view
    }()
    
    /// used for calculate layout
    var gridSpacing: CGFloat = DemoCalculatorView.Style.spacing
    var colums: Int = 4
    
    init(leftOneView: UIView, middleBarView: UIView, rightOneView: UIView) {
        self.leftOneView = leftOneView
        self.middleBarView = middleBarView
        self.rightOneView = rightOneView
        self.activeOne = leftOneView
        
        super.init(frame: .zero)
        
        addSubview(layoutStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        calculateLayoutMetric()
    }
    
    private func calculateLayoutMetric() {
        let containerSize = singleContainerSize(columnsInSingleOne: colums, spacing: gridSpacing)
        
        if self.frame.size.isPortrait {
            layoutStack.frame = self.bounds
            portrateLayout(singleContainerSize: containerSize)
        } else {
            let buttonSize = commandButtonSize(containerWidth: containerSize.width, columns: colums, spacing: gridSpacing)
            let barWidth = buttonSize.width + 2 * gridSpacing
            
            let totalWidth = self.frame.size.width
            let layoutStackWidth = 2.0 * containerSize.width + barWidth
            layoutStack.frame = CGRect(x: (totalWidth - layoutStackWidth) / 2.0, y: 0, width: layoutStackWidth, height: containerSize.height)
            
            landscapeLayout(singleContainerSize: containerSize)
        }
    }
    
    private func portrateLayout(singleContainerSize: CGSize) {
        updatePortraitUnitSize(singleContainerSize)
        
        middleBarView.isHidden = true
        leftOneView.isHidden = (leftOneView != activeOne)
        rightOneView.isHidden = (rightOneView != activeOne)
    }
    
    private func landscapeLayout(singleContainerSize: CGSize) {
        updateLandscapeUnitSize(singleContainerSize)
        updateBarConstraits(singleContainerSize: singleContainerSize)
        
        leftOneView.isHidden = false
        rightOneView.isHidden = false
        middleBarView.isHidden = false
    }
    
    private func updateBarConstraits(singleContainerSize: CGSize) {
        let buttonSize = commandButtonSize(containerWidth: singleContainerSize.width, columns: colums, spacing: gridSpacing)
        middleBarView.frame = CGRect(x: leftOneView.frame.maxX, y: 0, width: buttonSize.width + 2 * gridSpacing, height: singleContainerSize.height)
    }
    
    private func updatePortraitUnitSize(_ size: CGSize) {
        activeOne.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    private func updateLandscapeUnitSize(_ size: CGSize) {
        leftOneView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        rightOneView.frame = CGRect(x: middleBarView.frame.maxX, y: 0, width: size.width, height: size.height)
    }
    
    private func singleContainerSize(columnsInSingleOne: Int, spacing: CGFloat) -> CGSize {
        let selfSize = self.frame.size
        if selfSize.isPortrait {
            /// Portrait layout
            return selfSize
        }
        
        return CGSize(width: selfSize.height * 0.618, height: selfSize.height)
    }
    
    private func commandButtonSize(containerWidth: CGFloat, columns: Int, spacing: CGFloat) -> CGSize {
        let buttonWidth = (containerWidth - CGFloat(columns - 1) * spacing) / CGFloat(columns)
        return CGSize(
            width: buttonWidth,
            height: DemoCalculatorView.Style.buttonHeightRatio * buttonWidth)
    }
}
