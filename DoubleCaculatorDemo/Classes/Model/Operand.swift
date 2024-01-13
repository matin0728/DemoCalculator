//
//  Operand.swift
//  DoubleCalculatorDemo
//
//  Created by 马月瑶 on 2024/1/9.
//

import Foundation

/// The entity for interacting with user input.
final class Operand: OperandType {
    class var defaultValue: Operand {
        Operand(decimalNumber: NSDecimalNumber(decimal: 0))
    }
    
    typealias Input = InputCommand
    
    // MARK: Properties
    
    var isMutable: Bool {
        editable
    }
    
    // IMPORTANT: For simplicity, preset value is not editable, case it can be a sciencetific numerber format.
    private var presetDecimal: NSDecimalNumber
    private var editable: Bool
    
    var hasDot = false
    var isNagative: Bool
    
    /// The left part before dot.
    var rhs: [Character] = []
    /// The right part after dot.
    var lhs: [Character] = []
    
    var decimalValue: NSDecimalNumber {
        editable ? NSDecimalNumber(string: stringValue) : presetDecimal
    }
    
    var stringValue: String {
        if editable == false {
            return "\(presetDecimal.decimalValue)"
        }
        let theLhs = lhs.isEmpty ? ["0"] : lhs
        return (isNagative ? "-" : "") + String(theLhs) + ((hasDot && !rhs.isEmpty) ? "." : "") + String(rhs)
    }
    
    // MARK: Initializers
    
    init(lhs: [Character] = [], rhs: [Character] = [], isNagative: Bool = false) {
        self.editable = true
        self.rhs = rhs
        self.lhs = lhs
        self.hasDot = (false == rhs.isEmpty)
        self.isNagative = isNagative
        self.presetDecimal = .zero
    }
    
    init(decimalNumber: NSDecimalNumber) {
        self.editable = false
        self.isNagative = false
        self.presetDecimal = decimalNumber
    }
    
    // MARK: Interface
    
    func appendCharactor(_ charactor: Character) {
        guard editable else { return }
        
        if hasDot {
            rhs.append(charactor)
        } else {
            lhs.append(charactor)
        }
    }
    
    func appendDot() {
        hasDot = true
    }
    
    func removeLastCharactor() {
        guard editable else { return }
        
        if false == rhs.isEmpty {
            rhs.removeLast()
            return
        }
        
        if hasDot {
            hasDot = false
        }
        
        if false == lhs.isEmpty {
            lhs.removeLast()
        }
    }
    
    func toggleNagative() {
         isNagative = !isNagative
    }
    
    // - MARK: Private
    
    private func reset() {
        hasDot = false
        isNagative = false
        lhs = []
        rhs = []
        editable = true
    }
    
    private var hasNumber: Bool {
        !lhs.isEmpty || !rhs.isEmpty
    }
    
    // - MARK: OperandType
    
    func acceptInput(_ input: InputCommand) {
        if false == isMutable {
            reset()
        }
        switch input {
        case .calculate:
            assert(false)
            break
        case .clear:
            reset()
        case .dot:
            appendDot()
        case .delete:
            removeLastCharactor()
        case .digit(let digit):
            appendCharactor(digit.rawValue)
        case .reset:
            reset()
        case .operators(_):
            assert(false)
            break
        case .transferToRight:
            break
        case .transferLeft:
            break
        case .transformer(_):
            assert(false)
            break
        }
    }
}
