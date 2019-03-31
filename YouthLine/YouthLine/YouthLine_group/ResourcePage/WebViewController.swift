//
//  WebViewController.swift
//  YouthLine
//
//  Created by Yuting Shao on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: BaseViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var url : URL!
    //    var offset: Int = 0
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        // 1
        //        print(url!)
        //        let url = URL(string: "https://settlement.org/ontario/health/sexual-and-reproductive-health/sexual-orientation-and-gender-identity/")!
        print(url)
        webView.load(URLRequest(url: url))
        
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
