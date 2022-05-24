//
//  IPDetailViewController.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/22.
//

import UIKit
import SnapKit
import WebKit

class IPPoemViewController: UIViewController, WKNavigationDelegate {

    var poem: IPPoem!
    convenience init(poem: IPPoem) {
        self.init(nibName: nil, bundle: nil)
        self.poem = poem
    }
    
    lazy var webview: WKWebView = {
        let webview = WKWebView()
        webview.navigationDelegate = self
        let fontFamily = "FZSKBXKJW--GB1-0"
        if let fontUrl = Bundle.main.url(forResource: "FZSongKeBenXiuKaiS-R-GB", withExtension: "ttf") {
            do {
                let fontData = try Data(contentsOf: fontUrl, options: .mappedIfSafe)
                let fontEncoding = fontData.base64EncodedString()
                
                let scriptFormat = "var fontcss = '@font-face { font-family: \"%@\"; src: url(data:font/ttf;base64,%@) format(\"truetype\");} *{font-family: \"%@\" !important;}';var head = document.getElementsByTagName('head')[0],style = document.createElement('style');style.type = 'text/css';style.innerHTML = fontcss;head.appendChild(style);"
                
                let fontScript = String(format: scriptFormat, fontFamily, fontEncoding, fontFamily)
                let userScript = WKUserScript(source: fontScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
                webview.configuration.userContentController.addUserScript(userScript)
            } catch {
                debugPrint("\(self.debugDescription) ===> 获取字体文件出错")
            }
        }
        return webview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(webview)
        webview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "detail_more")?.original(), style: .plain, target: self, action: #selector(moreEvent)),
                                              UIBarButtonItem(image: UIImage(named: "detail_fav")?.original(), style: .plain, target: self, action: #selector(favEvent))]
        if let path = Bundle.main.path(forResource: poem.fileName, ofType: "")  {
            
            do {
                let content = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
                webview.loadHTMLString(String(content), baseURL: nil)
            } catch let error {
                print(error)
            }
        }
        
        reloadFav()
    }
    
    func changeFont() {        
        let fontFamily = "FZSKBXKJW--GB1-0"
        if let fontUrl = Bundle.main.url(forResource: "FZSongKeBenXiuKaiS-R-GB", withExtension: "ttf") {
            do {
                let fontData = try Data(contentsOf: fontUrl, options: .mappedIfSafe)
                let fontEncoding = fontData.base64EncodedString()
                
                let scriptFormat = "var fontcss = '@font-face { font-family: \"%@\"; src: url(data:font/ttf;base64,%@) format(\"truetype\");} *{font-family: \"%@\" !important;}';var head = document.getElementsByTagName('head')[0],style = document.createElement('style');style.type = 'text/css';style.innerHTML = fontcss;head.appendChild(style);"
                
                let fontScript = String(format: scriptFormat, fontFamily, fontEncoding, fontFamily)
                self.webview.evaluateJavaScript(fontScript)
            } catch {
                debugPrint("\(self.debugDescription) ===> 获取字体文件出错")
            }
        } else {
            debugPrint("\(self.debugDescription) ===> 字体文件不存在")
        }
        
        if UIDevice.isIphone {
            webview.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '120%'")
        }

//        let javascript = "document.getElementsByTagName('body')[0].style.fontFamily='FZSKBXKJW--GB1-0';"
//        webview.evaluateJavaScript(javascript) { obj, error in
//            if let error = error {
//                print(error)
//                return
//            }
//            print(obj)
//        }
        
//        webview.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'")
        
//        webview.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#9098b8'")
       
    }
    
    func reloadFav() {
        if let item = navigationItem.rightBarButtonItems?.last {
            
            if poem.isFav {
                item.image = UIImage(named: "detail_fav")?.withTintColor(.rgb(0xf15642)).original()
            } else {
                item.image = UIImage(named: "detail_fav")?.original()
            }
        }
    }
    
    @objc func moreEvent() {
        guard let window = view.window else { return }
        let titles = [poem.title, poem.name]
        let moreView = IPPoemMoreView(titles: titles)
        window.addSubview(moreView)
        moreView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        moreView.didSelectItem = {[weak self] index in
            let url = URL(string: String.baike(titles[index]))
            let request = URLRequest(url: url!)
            let vc = IPWebViewController(request: request)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @objc func favEvent() {
        if poem.isFav {
            IPPoemFavManager.shared.removeFav(poem)
        } else {
            IPPoemFavManager.shared.addFav(poem)
        }
        reloadFav()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {

    }
}
