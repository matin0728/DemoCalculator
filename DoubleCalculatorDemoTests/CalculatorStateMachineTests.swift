//
//  CalculatorStateMachineTests.swift
//  DoubleCalculatorDemoTests
//
//  Created by 马月瑶 on 2024/1/10.
//

import XCTest
@testable import DoubleCalculatorDemo

final class CalculatorStateMachineTests: XCTestCase {
    
    var machine: CalculatorStateMachine = CalculatorStateMachine(lhs: Operand(), rhs: Operand())
    let operators: Operators = {
        let ops = Operators()
        ops.loadDefaultOperator()
        return ops
    }()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        machine = CalculatorStateMachine(lhs: Operand(), rhs: Operand())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// 1 + 1 =
    func testItShouldCalculateTwoOperand() throws {
        machine.acceptInput(.digit(.one))
        machine.setOperators(operators.operatorNamed(OperatorName.plus), name: OperatorName.plus)
        machine.acceptInput(.digit(.one))
        machine.calculateResult()
        
        XCTAssertEqual(machine.result.decimalValue, NSDecimalNumber(floatLiteral: 2))
    }
    
    /// 1 + 1 + 1 =
    func testItShouldContinueCalcuateWithLastResult() throws {
        machine.acceptInput(.digit(.one))
        machine.setOperators(operators.operatorNamed(OperatorName.plus), name: OperatorName.plus)
        machine.acceptInput(.digit(.one))
        machine.setOperators(operators.operatorNamed(OperatorName.plus), name: OperatorName.plus)
        machine.acceptInput(.digit(.one))
        machine.calculateResult()
        
        XCTAssertEqual(machine.result.decimalValue, NSDecimalNumber(floatLiteral: 3))
    }
    
    /// 1 + 1 + =
    func testItShouldContinueCalcuateWithSelf() throws {
        machine.acceptInput(.digit(.one))
        machine.setOperators(operators.operatorNamed(OperatorName.plus), name: OperatorName.plus)
        machine.acceptInput(.digit(.one))
        machine.setOperators(operators.operatorNamed(OperatorName.plus), name: OperatorName.plus)
        machine.calculateResult()
        
        XCTAssertEqual(machine.result.decimalValue, NSDecimalNumber(floatLiteral: 4))
    }
}
