//
//  ViewController.swift
//  WebViewExample
//
//  Created by Illia Kharebashvili on 24.01.2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openWebViewButtonDidTap() {
        let webVC = WebViewController()
        webVC.modalPresentationStyle = .fullScreen
        present(webVC, animated: true)
    }
}
