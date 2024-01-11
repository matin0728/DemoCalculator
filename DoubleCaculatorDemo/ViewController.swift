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
    
    lazy var calculator: DemoCalculator = {
        let theCalculator = DemoCalculator(operators: operators)
        theCalculator.updateCallback = { [unowned self] in
            self.refreshResultDisplay()
        }
        return theCalculator
    }()
    
    lazy var calculatorView = DemoCalculatorView(commands: KeyboardLayout.commands({ [unowned self] command in
        self.calculator.execCommand(command)
    }))
    
    var containerView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let demo = DemoCalculator()
//        demo.execCommand(.digit(.one))
//        demo.execCommand(.operators(.addition))
//        demo.execCommand(.digit(.one))
//        demo.execCommand(.calculate)
//        
//        print("result: \(demo.resultOutput)")
//        print("Operand: \(demo.operandOutput)")
        
        view.backgroundColor = .black
        view.addSubview(calculatorView)
        
        let left = UIView(frame: .zero)
        left.backgroundColor = .red
        
        let right = UIView(frame: .zero)
        right.backgroundColor = .blue
        
        let bar = UIView(frame: .zero)
        bar.backgroundColor = .orange
        
        let container = DemoCalculatorContainerView(leftOneView: left, middleBarView: bar, rightOneView: right)
        self.containerView = container
        view.addSubview(container)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Get the safe area insets
        let safeAreaInsets = view.safeAreaInsets
        let insets = UIEdgeInsets(top: safeAreaInsets.top, left: safeAreaInsets.left, bottom: safeAreaInsets.bottom + 20, right: safeAreaInsets.right)
        calculatorView.frame = self.view.bounds.inset(by: insets)
        
        containerView.frame = calculatorView.frame
    }
    
    func refreshResultDisplay() {
        calculatorView.set(resultString: calculator.resultOutput, operandString: calculator.operandOutput)
    }
}

