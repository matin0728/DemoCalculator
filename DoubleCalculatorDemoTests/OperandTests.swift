//
//  OperandTests.swift
//  DoubleCalculatorDemoTests
//
//  Created by 马月瑶 on 2024/1/9.
//

import XCTest
@testable import DoubleCalculatorDemo

final class OperandTests: XCTestCase {
    
    var operand: Operand = Operand(decimalNumber: .zero)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testItShouldBeEditable() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        operand = Operand()
        operand.appendCharactor("1")
        operand.appendCharactor("2")
        operand.appendCharactor("3")
        XCTAssertEqual(operand.stringValue, "123")
        XCTAssertNotEqual(operand.decimalValue, .zero)
        operand.appendDot()
        XCTAssertEqual(operand.stringValue, "123")
        operand.appendDot()
        XCTAssertEqual(operand.stringValue, "123")
        
        operand.appendCharactor("1")
        operand.appendCharactor("2")
        XCTAssertEqual(operand.stringValue, "123.12")
        
        operand.removeLastCharactor()
        XCTAssertEqual(operand.stringValue, "123.1")
        
        operand.removeLastCharactor()
        XCTAssertEqual(operand.stringValue, "123")
        
        operand.removeLastCharactor()
        XCTAssertEqual(operand.stringValue, "12")
        
        operand.removeLastCharactor()
        operand.removeLastCharactor()
        operand.removeLastCharactor()
        XCTAssertEqual(operand.stringValue, "0")
        
        // Toggle nagative should not affect zero value.
        operand.toggleNagative()
        XCTAssertEqual(operand.stringValue, "-0")
        
        operand.appendDot()
        operand.appendCharactor("5")
        operand.toggleNagative()
        XCTAssertEqual(operand.stringValue, "0.5")
        
        operand.toggleNagative()
        XCTAssertEqual(operand.stringValue, "-0.5")
    }
    
    func testItShouldConverToDecimalNumber() throws {
        operand = Operand()
        operand.appendCharactor("1")
        operand.appendCharactor("0")
        operand.appendCharactor("0")
        operand.appendDot()
        operand.appendCharactor("0")
        
        let decimal = operand.decimalValue
        XCTAssertEqual(decimal, NSDecimalNumber(floatLiteral: 100))
        
        operand = Operand()
        operand.appendCharactor("1")
        operand.appendCharactor("0")
        operand.appendDot()
        operand.appendCharactor("1")
        let decimal2 = operand.decimalValue
        XCTAssertNotEqual(decimal2, NSDecimalNumber(floatLiteral: 10))
    }
    
    func testItShouldClearInputNumber() throws {
        operand = Operand()
        operand.appendCharactor("1")
        operand.appendCharactor("2")
        operand.appendCharactor("3")
        operand.acceptInput(.clear)
        XCTAssertEqual(operand.stringValue, "0")
    }
    
    func testItShouldNotBeEditable() throws {
        operand = Operand(decimalNumber: .maximum)
        operand.appendCharactor("1")
        operand.appendDot()
        XCTAssertEqual(operand.decimalValue, .maximum)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
