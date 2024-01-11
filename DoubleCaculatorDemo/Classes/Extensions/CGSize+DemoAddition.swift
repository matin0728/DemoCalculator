//
//  CGSize+DemoAddition.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/11.
//

import Foundation

extension CGSize {
    var isPortrait: Bool {
        self.width < self.height
    }
    
    var isHorizontal: Bool {
        !isPortrait
    }
}
