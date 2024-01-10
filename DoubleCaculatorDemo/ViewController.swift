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
    
    var commands: [[CommandKeyViewModel]] {
        let excution: (InputCommand) -> Void = { [unowned self] command in
            self.calculator.execCommand(command)
        }
        return [
            [CommandKeyViewModel(
                command: .init(name: .reset,
                               buttonText: "\(InputCommand.reset)",
                               excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .operators(.reverse),
                               buttonText: OperatorName.reverse.rawValue,
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .operators(.percent),
                               buttonText: OperatorName.percent.rawValue,
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .operators(.division),
                               buttonText: OperatorName.division.rawValue,
                                excutionCallback: excution))],
            [CommandKeyViewModel(
                command: .init(name: .digit(.seven),
                               buttonText: "\(InputCommand.digit(.seven))",
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .digit(.eight),
                               buttonText: "\(InputCommand.digit(.eight))",
                                excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .digit(.nine),
                               buttonText: "\(InputCommand.digit(.nine))",
                               excutionCallback: excution)),
             CommandKeyViewModel(
                command: .init(name: .operators(.multiplication),
                               buttonText: OperatorName.multiplication.rawValue,
                                excutionCallback: excution), backgroundColor: .orange)]
        ]
    }
    
    lazy var calculator: DemoCalculator = DemoCalculator(operators: operators)
    
    lazy var caculatorView = DemoCalculatorView(commands: commands)

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
        view.addSubview(caculatorView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Get the safe area insets
        let safeAreaInsets = view.safeAreaInsets
        let insets = UIEdgeInsets(top: safeAreaInsets.top, left: safeAreaInsets.left, bottom: safeAreaInsets.bottom + 20, right: safeAreaInsets.right)
        caculatorView.frame = self.view.bounds.inset(by: insets)
    }
}

