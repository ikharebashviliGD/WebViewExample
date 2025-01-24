//
//  WebViewController.swift
//  WebViewExample
//
//  Created by Illia Kharebashvili on 24.01.2025.
//

import UIKit
import WebKit

// Decodable struct for JSON messages from JS
private struct ScriptMessage: Decodable {
    let type: String
    let pnr: String?
    let firstName: String?
    let lastName: String?
}

final class WebViewController: UIViewController {

    // WKWebView initialized with a custom configuration
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "groupapp")
        configuration.userContentController = userContentController
        
        let webpagePreferences = WKWebpagePreferences()
        webpagePreferences.allowsContentJavaScript = true
        configuration.defaultWebpagePreferences = webpagePreferences
        
        return WKWebView(frame: .zero, configuration: configuration)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = webView
        loadLocalHTML()
    }
    
    // Load local HTML file
    private func loadLocalHTML() {
        guard let filePath = Bundle.main.path(forResource: "web_page", ofType: "html") else {
            print("web_page.html not found.")
            return
        }
        let url = URL(fileURLWithPath: filePath)
        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
#if DEBUG
       if #available(iOS 16.4, *) {
          webView.isInspectable = true
       }
#endif
    }
}

// Handle JavaScript messages
extension WebViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        
        guard message.name == "groupapp",
              let bodyString = message.body as? String,
              let jsonData = bodyString.data(using: .utf8) else { return }
        
        do {
            let scriptMessage = try JSONDecoder().decode(ScriptMessage.self, from: jsonData)
            switch scriptMessage.type {
            case "RefXBookingConfirmed":
                // Handle confirmation if needed
                break
            case "RefXFlowEnd":
                dismiss(animated: true)
            default:
                break
            }
        } catch {
            print("Failed to decode script message: \(error)")
        }
    }
}
