//
//  ViewController.swift
//  DoubleCaculatorDemo
//
//  Created by 马月瑶 on 2024/1/7.
//

import UIKit

class ViewController: UIViewController {
    var operators: Operators {
        let all = Operators()
        all.loadDefaultOperator()
        return all
    }
    
    lazy var calculatorApp: DemoCalculatorApp = {
        let app = DemoCalculatorApp()
        app.leftOne.updateCallback = { [unowned self] in
            self.lhsCalculatorView.set(
                resultString: self.calculatorApp.leftOne.resultOutput,
                operandString: self.calculatorApp.leftOne.operandOutput)
        }
        app.rightOne.updateCallback = { [unowned self] in
            self.rhsCalculatorView.set(
                resultString: self.calculatorApp.rightOne.resultOutput,
                operandString: self.calculatorApp.rightOne.operandOutput)
        }
        return app
    }()
    
    lazy var lhsCalculatorView = DemoCalculatorView(commands: KeyboardLayout.commands({ [unowned self] command in
        self.calculatorApp.activeLeftOne()
        self.containerView.activeOne = self.containerView.leftOneView
        self.calculatorApp.execCommmand(command)
    }))
    
    lazy var rhsCalculatorView = DemoCalculatorView(commands: KeyboardLayout.commands({ [unowned self] command in
        self.calculatorApp.activeRightOne()
        self.containerView.activeOne = self.containerView.rightOneView
        self.calculatorApp.execCommmand(command)
    }))
    
    lazy var barView: UIView = {
        let bar = UIView(frame: .zero)
        bar.backgroundColor = .orange
        return bar
    }()
    
    lazy var containerView: DemoCalculatorContainerView = {
        DemoCalculatorContainerView(
            leftOneView: lhsCalculatorView,
            middleBarView: self.barView,
            rightOneView: rhsCalculatorView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(containerView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Get the safe area insets
        let safeAreaInsets = view.safeAreaInsets
        let insets = UIEdgeInsets(top: safeAreaInsets.top, left: safeAreaInsets.left, bottom: safeAreaInsets.bottom + 20, right: safeAreaInsets.right)
        
        containerView.frame = self.view.bounds.inset(by: insets)
    }
}

