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
    
    /* lazy var calculator: DemoCalculator = {
        let theCalculator = DemoCalculator(operators: operators)
        theCalculator.updateCallback = { [unowned self] in
            self.refreshResultDisplay()
        }
        return theCalculator
    }() */
    
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
        self.calculatorApp.execCommmand(command)
    }))
    
    lazy var rhsCalculatorView = DemoCalculatorView(commands: KeyboardLayout.commands({ [unowned self] command in
        self.calculatorApp.activeRightOne()
        self.calculatorApp.execCommmand(command)
    }))
    
    var containerView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        /* let left = UIView(frame: .zero)
        left.backgroundColor = .red
        
        let right = UIView(frame: .zero)
        right.backgroundColor = .blue */
        
        let bar = UIView(frame: .zero)
        bar.backgroundColor = .orange
        
        let container = DemoCalculatorContainerView(
            leftOneView: lhsCalculatorView,
            middleBarView: bar,
            rightOneView: rhsCalculatorView)
        self.containerView = container
        view.addSubview(container)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Get the safe area insets
        let safeAreaInsets = view.safeAreaInsets
        let insets = UIEdgeInsets(top: safeAreaInsets.top, left: safeAreaInsets.left, bottom: safeAreaInsets.bottom + 20, right: safeAreaInsets.right)
        // calculatorView.frame = self.view.bounds.inset(by: insets)
        
        containerView.frame = self.view.bounds.inset(by: insets)
    }
    
//    func refreshResultDisplay() {
//        calculatorView.set(resultString: calculator.resultOutput, operandString: calculator.operandOutput)
//    }
}

