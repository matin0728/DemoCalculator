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
        machine.setOperator(OperatorSet.operatorNamed(.addition))
        machine.acceptInput(.digit(.one))
        machine.calculateResult()
        
        XCTAssertEqual(machine.result.decimalValue, NSDecimalNumber(floatLiteral: 2))
    }
    
    /// 1 + 1 + 1 =
    func testItShouldContinueCalcuateWithLastResult() throws {
        machine.acceptInput(.digit(.one))
        machine.setOperator(OperatorSet.operatorNamed(.addition))
        machine.acceptInput(.digit(.one))
        machine.setOperator(OperatorSet.operatorNamed(.addition))
        machine.acceptInput(.digit(.one))
        machine.calculateResult()
        
        XCTAssertEqual(machine.result.decimalValue, NSDecimalNumber(floatLiteral: 3))
    }
    
    /// 1 + 1 + =
    func testItShouldContinueCalcuateWithSelf() throws {
        machine.acceptInput(.digit(.one))
        machine.setOperator(OperatorSet.operatorNamed(.addition))
        machine.acceptInput(.digit(.one))
        machine.setOperator(OperatorSet.operatorNamed(.addition))
        machine.calculateResult()
        
        XCTAssertEqual(machine.result.decimalValue, NSDecimalNumber(floatLiteral: 4))
    }
    
    /// 1 + 2 x 3 =
    func testItShouldFollowHumanPrinciple() throws {
        machine.acceptInput(.digit(.one))
        machine.setOperator(OperatorSet.operatorNamed(.addition))
        machine.acceptInput(.digit(.two))
        machine.setOperator(OperatorSet.operatorNamed(.multiplication))
        machine.acceptInput(.digit(.three))
        machine.calculateResult()
        XCTAssertEqual(machine.result.decimalValue, NSDecimalNumber(floatLiteral: 9))
    }
    
    /// 1 + 2 x 3 =
    func testItShouldNotFollowMathimaticalPrinciple() throws {
        machine.acceptInput(.digit(.one))
        machine.setOperator(OperatorSet.operatorNamed(.addition))
        machine.acceptInput(.digit(.two))
        machine.setOperator(OperatorSet.operatorNamed(.addition))
        machine.acceptInput(.digit(.three))
        machine.calculateResult()
        XCTAssertNotEqual(machine.result.decimalValue, NSDecimalNumber(floatLiteral: 7))
    }
}
