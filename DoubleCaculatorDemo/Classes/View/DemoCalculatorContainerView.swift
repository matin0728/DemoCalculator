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
    struct Style {
        static let barPadding: CGFloat = 10.0
    }
    let leftOneView: UIView
    private lazy var leftWidthContraint = leftOneView.widthAnchor.constraint(equalToConstant: 0)
    private lazy var leftHeightContraint = leftOneView.heightAnchor.constraint(equalToConstant: 0)
    
    let middleBarView: UIView
    private lazy var barWidthContraint = middleBarView.widthAnchor.constraint(equalToConstant: 0)
    private lazy var barHeightContraint = middleBarView.heightAnchor.constraint(equalToConstant: 0)
    
    let rightOneView: UIView
    private lazy var rightWidthContraint = rightOneView.widthAnchor.constraint(equalToConstant: 0)
    private lazy var rightHeightContraint = rightOneView.heightAnchor.constraint(equalToConstant: 0)
    
    var activeOne: UIView
    
    private lazy var layoutStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftOneView, middleBarView, rightOneView])
        view.spacing = 0 // Style.barPadding
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .equalSpacing
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
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        calculateLayoutMetric()
    }
    
    private func calculateLayoutMetric() {
        print("TotalSize: \(self.frame.size)")
        
        let containerSize = singleContainerSize(columnsInSingleOne: colums, spacing: gridSpacing)
        
        print("Container: \(containerSize)")
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
        updateUnitConstraite(singleContainerSize: singleContainerSize)
        
        middleBarView.isHidden = true
        leftOneView.isHidden = (leftOneView != activeOne)
        rightOneView.isHidden = (rightOneView != activeOne)
    }
    
    private func landscapeLayout(singleContainerSize: CGSize) {
        updateUnitConstraite(singleContainerSize: singleContainerSize)
        updateBarConstraits(singleContainerSize: singleContainerSize)
        
        leftOneView.isHidden = false
        rightOneView.isHidden = false
        middleBarView.isHidden = false
    }
    
    private func updateBarConstraits(singleContainerSize: CGSize) {
        barWidthContraint.constant = self.frame.size.width - singleContainerSize.width * 2 - 2 * Style.barPadding
        barHeightContraint.constant = singleContainerSize.height
    }
    
    private func updateUnitConstraite(singleContainerSize: CGSize) {
        leftWidthContraint.constant = singleContainerSize.width
        leftHeightContraint.constant = singleContainerSize.height
        
        rightWidthContraint.constant = singleContainerSize.width
        rightHeightContraint.constant = singleContainerSize.height
    }
    
    private func setupSubviews() {
        // Adding constraints
        NSLayoutConstraint.activate([
            leftWidthContraint,
            leftHeightContraint,
            barWidthContraint,
            barHeightContraint,
            rightWidthContraint,
            rightHeightContraint
        ])
    }
    
    private func singleContainerSize(columnsInSingleOne: Int, spacing: CGFloat) -> CGSize {
        let selfSize = self.frame.size
        if selfSize.isPortrait {
            /// Portrait layout
            return selfSize
        }
        
        return CGSize(width: selfSize.height * 0.55, height: selfSize.height)
        
        // Lanscape layout
//        let buttonWidth = (selfSize.width - CGFloat(columnsInSingleOne) * 2 * spacing) / (CGFloat(columnsInSingleOne) * 2 + 1)
//        
//        return CGSize(width: (buttonWidth + spacing) * CGFloat(columnsInSingleOne) - spacing, height: selfSize.height)
    }
    
    private func commandButtonSize(containerWidth: CGFloat, columns: Int, spacing: CGFloat) -> CGSize {
        let buttonWidth = (containerWidth - CGFloat(columns - 1) * spacing) / CGFloat(columns)
        return CGSize(
            width: buttonWidth,
            height: DemoCalculatorView.Style.buttonHeightRatio * buttonWidth)
    }
}
