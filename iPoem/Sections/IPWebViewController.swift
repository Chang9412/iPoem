//
//  IPWebViewController.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/23.
//

import UIKit
import WebKit
import SnapKit

class IPWebViewController: UIViewController, IPViewControllGobackDelegate {

    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        return webView
    }()
    
    var request: URLRequest!
    convenience init(request: URLRequest) {
        self.init(nibName: nil, bundle: nil)
        self.request = request
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        webView.load(request)
        reloadBarItem()
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "title")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath, keyPath == "title", let object = object as? WKWebView, object == webView  {
            navigationItem.title = webView.title
        }
    }
    
    func ipnGoback() {
        if webView.canGoBack {
            webView.goBack()
            return
        }
        if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }

    @objc func back() {
        ipnGoback()
    }
    
    @objc func quit() {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    
    func reloadBarItem() {
        let back = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: self, action: #selector(back))
        back.tintColor = .white
        var items = [UIBarButtonItem]()
        items.append(back)
        if webView.canGoBack || webView.canGoBack {
            let quit = UIBarButtonItem(image: UIImage(named: "nav_quit"), style: .plain, target: self, action: #selector(quit))
            items.append(quit)
        }
        navigationItem.leftBarButtonItems = items
    }
    

}

extension IPWebViewController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {

    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        reloadBarItem()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        
        return .allow
    }
    
        
}
