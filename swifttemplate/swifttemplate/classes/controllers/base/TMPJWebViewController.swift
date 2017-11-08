//
//  TMPJWebViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//
import WebKit
import Airmey

class TMPJWebViewController: TMPJBaseViewController,WKNavigationDelegate,WKUIDelegate {
    var webLink :String?
    var showToolBar:Bool = false;
    var progressView:UIProgressView!
    private var webURL:URL?
    
    lazy var webView:WKWebView = {
        let wbview = WKWebView(frame: self.view.bounds);
        wbview.scrollView.panGestureRecognizer.addTarget(self, action: #selector(TMPJWebViewController.panAction(_:)))
        wbview.scrollView.keyboardDismissMode = .onDrag;
        wbview.navigationDelegate = self;
        wbview.uiDelegate = self;
        return wbview;
    }()
    private lazy var backBarButtonItem:UIBarButtonItem = {
        let image = UIImage(named: "icon_return_black")
        let item = UIBarButtonItem(image: image, style: .plain, target: self.webView, action: #selector(WKWebView.goBack));
        item.width = 18.0;
        return item;
    }();
    private lazy var forwardBarButtonItem:UIBarButtonItem = {
        let image = UIImage(named: "icon_return_black")
        let item = UIBarButtonItem(image: image, style: .plain, target: self.webView, action: #selector(WKWebView.goForward));
        item.width = 18.0;
        return item;
    }();
    private lazy var refreshBarButtonItem:UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .refresh, target: self.webView, action: #selector(WKWebView.reload))
    }();
    convenience init(link:String?,showToolBar:Bool) {
        self.init()
        self.webLink = link
        self.showToolBar = showToolBar
    }
    deinit
    {
        self.webView.uiDelegate=nil;
        self.webView.navigationDelegate=nil;
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        self.view.addSubview(self.webView);
        self.progressView = UIProgressView(progressViewStyle: .bar);
        self.view.addSubview(self.progressView);
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);
        
        if let link = self.webLink{
            self.webURL = URL(string:link);
        }
        if let url = self.webURL {
            self.webView.load(URLRequest(url: url));
        }
        else
        {
            self.showAlertMessage("网络地址错误", clickedAction: nil);
        }
    }
    override func leftItemAction(_ sender: AnyObject!) {
        _ = self.navigationController?.popViewController(animated: true);
        self.webView.stopLoading();
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if (self.showToolBar == true) {
            self.navigationController?.toolbarItems = nil;
            self.navigationController?.isToolbarHidden = true;
        }
    }
    @objc func panAction(_ pan:UIPanGestureRecognizer)
    {
        switch pan.state
        {
        case .began:break;
        case .ended:
            let velocity  = pan.velocity(in: self.view)
            if velocity.y<0
            {
                self.navigationController?.setNavigationBarHidden(true, animated: true);
                if self.showToolBar
                {
                    self.navigationController?.setToolbarHidden(true, animated: true);
                }
                self.setNeedsStatusBarAppearanceUpdate();
            }
            else if(velocity.y>600||self.webView.scrollView.contentOffset.y<=10)
            {
                self.navigationController?.setNavigationBarHidden(false, animated: true);
                if self.showToolBar
                {
                    self.navigationController?.setToolbarHidden(false, animated: true);
                }
                self.setNeedsStatusBarAppearanceUpdate();
            }
            break;
        default:
            let offsetPoint = pan.translation(in: self.view);
            if (offsetPoint.y<0)
            {
                let offsety = offsetPoint.y*0.1;
                let top = self.navigationController!.toolbar.top;
                var barTop = top-offsety;
                if (barTop>self.view.bottom) {
                    barTop=self.view.bottom;
                }
                self.navigationController!.toolbar.top = barTop;
            }
            break;
        }
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideWaiting();
        self.navigationItem.title=webView.title;
        self.updateToolbarItems();
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hideWaiting();
        if (error._code==NSURLErrorTimedOut||error._code==NSURLErrorNotConnectedToInternet) {
            self.showAlertMessage("无法打开网页请检查网络设置\n然后点击屏幕重试",clickedAction:nil);
        }
        self.updateToolbarItems();
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showWaitingActivity();
        self.updateToolbarItems();
    }
    func updateToolbarItems()
    {
        if self.showToolBar
        {
            self.backBarButtonItem.isEnabled=self.webView.canGoBack;
            self.forwardBarButtonItem.isEnabled=self.webView.canGoForward;
            let fixedSide = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil);
            fixedSide.width = 5;
            let fixedMiddle = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
            
            self.toolbarItems = [fixedSide,self.backBarButtonItem,fixedMiddle,self.refreshBarButtonItem,fixedMiddle,self.forwardBarButtonItem,fixedSide];
        }
    }
    //#mark kvo
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"
        {
            let newprogress = self.webView.estimatedProgress;
            if (newprogress == 1) {
                self.progressView.isHidden = true;
                self.progressView.setProgress(0, animated: false);
            }else {
                self.progressView.isHidden = false;
                self.progressView.setProgress(Float(newprogress), animated: true)
            }
        }
    }
}

