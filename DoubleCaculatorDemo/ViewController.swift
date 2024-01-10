//
//  ViewController.swift
//  DoubleCaculatorDemo
//
//  Created by 马月瑶 on 2024/1/7.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let demo = DemoCalculator()
        demo.execCommand(.digit(.one))
        demo.execCommand(.operators(.plus))
        demo.execCommand(.digit(.one))
        demo.execCommand(.calculate)
        
        print("result: 1 + 1 = \(demo.resultOutput)")
        print("resultO: \(demo.operandOutput) = \(demo.resultOutput)")
    }


}

