//
//  TMPJWebViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//
import WebKit
import Airmey

class TMPJWebViewController: TMPJBaseViewController {
    var weburl:URL?
    let webview = WKWebView()
    init(link:String?) {
        if let str = link?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            self.weburl = URL(string: str)
        }
        super.init()
        self.webview.translatesAutoresizingMaskIntoConstraints = false
        self.webview.scrollView.keyboardDismissMode = .onDrag
        self.webview.navigationDelegate = self
        self.webview.uiDelegate = self
        if #available(iOS 11.0, *) {
            self.webview.scrollView.contentInsetAdjustmentBehavior = .never
        }
    }
    convenience required init?(coder aDecoder: NSCoder) {
        return nil
    }
    deinit{
        self.webview.uiDelegate=nil;
        self.webview.navigationDelegate=nil;
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        self.view.addSubview(self.webview)
        self.webview.adhere(insets: (self.topbarInset,nil,self.bottomInset,nil))
        guard let url = self.weburl else {
            self.remind(#imageLiteral(resourceName: "remind_offline_gray"),text: "网络地址错误")
            return
        }
        self.webview.load(URLRequest(url: url))
    }
    override func leftItemAction(_ sender: AnyObject!) {
        self.webview.stopLoading()
        self.navigationController?.popViewController(animated: true)
    }
}
extension TMPJWebViewController:WKNavigationDelegate,WKUIDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideWaiting();
        self.navigationItem.title=webView.title;
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hideWaiting();
        if (error._code==NSURLErrorTimedOut||error._code==NSURLErrorNotConnectedToInternet) {
            self.remind(#imageLiteral(resourceName: "remind_offline_gray"),text: "无法打开网页请检查网络设置\n然后点击屏幕重试")
        }
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showWaiting()
    }
}
