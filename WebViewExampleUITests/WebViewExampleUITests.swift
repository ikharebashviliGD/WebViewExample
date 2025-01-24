//
//  WebViewExampleUITests.swift
//  WebViewExampleUITests
//
//  Created by Illia Kharebashvili on 24.01.2025.
//

import XCTest
import EvincedXCUISDK

final class WebViewExampleUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        try EvincedEngine.setupCredentials(serviceAccountId: "",
                                       apiKey: "")
        EvincedEngine.testCase = self
        EvincedEngine.options.screenshotOptions = .disabled
    }

    override func tearDownWithError() throws {
        try EvincedEngine.reportStored()
    }

    func testContinuousMode() throws {
        let app = XCUIApplication()
        app.launch()
        EvincedEngine.startAnalyze()
        app.buttons["Open WebView"].tap()
        
        app.links["Proceed to confirmation"].waitAndTap()
        app.links["My flights"].tap()
        EvincedEngine.stopAnalyze()
    }
    
    func testEvReport() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Open WebView"].tap()
        
        app.links["Proceed to confirmation"].wait()
        try EvincedEngine.report()
        app.links["My flights"].tap()
        try EvincedEngine.report()
    }
    
    func testEvAnalyze() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Open WebView"].tap()
        
        app.links["Proceed to confirmation"].wait()
        try app.evAnalyze()
        app.links["My flights"].tap()
        try app.evAnalyze()
    }
}
