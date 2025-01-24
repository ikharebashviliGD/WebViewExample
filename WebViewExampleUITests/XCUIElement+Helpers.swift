//
//  XCUIElement+Helpers.swift
//  WebViewExampleUITests
//
//  Created by Illia Kharebashvili on 24.01.2025.
//

import XCTest

extension XCUIElement {
    func wait(timeout: TimeInterval = 3) {
        XCTAssertTrue(waitForExistence(timeout: timeout))
    }
    
    func waitAndTap(timeout: TimeInterval = 3) {
        wait(timeout: timeout)
        tap()
    }
    
    func waitForExistence(timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
}
