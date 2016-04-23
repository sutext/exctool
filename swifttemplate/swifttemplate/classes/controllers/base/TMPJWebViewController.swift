//
//  TMPJWebViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import WebKit
import EasyTools

class TMPJWebViewController: TMPJBaseViewController,WKNavigationDelegate,WKUIDelegate {
    var webLink :String?
    var showToolBar:Bool = false;
    var progressView:UIProgressView!
    private var webURL:NSURL?
    
    lazy var webView:WKWebView = {
        let wbview = WKWebView(frame: self.view.bounds);
        wbview.scrollView.panGestureRecognizer.addTarget(self, action: Selector("panAction:"))
        wbview.scrollView.keyboardDismissMode = .OnDrag;
        wbview.navigationDelegate = self;
        wbview.UIDelegate = self;
        return wbview;
    }()
    private lazy var backBarButtonItem:UIBarButtonItem = {
        let image = UIImage.arrowWithDirection(.Left);
        let item = UIBarButtonItem(image: image, style: .Plain, target: self.webView, action: Selector("goBack"));
        item.width = 18.0;
        return item;
    }();
    private lazy var forwardBarButtonItem:UIBarButtonItem = {
        let image = UIImage.arrowWithDirection(.Right);
        let item = UIBarButtonItem(image: image, style: .Plain, target: self.webView, action: Selector("goForward"));
        item.width = 18.0;
        return item;
    }();
    private lazy var refreshBarButtonItem:UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .Refresh, target: self.webView, action: Selector("reload"))
    }();
    convenience init(link:String?,showToolBar:Bool) {
        self.init();
    }
    deinit
    {
        self.webView.UIDelegate=nil;
        self.webView.navigationDelegate=nil;
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.whiteColor();
        self.view.addSubview(self.webView);
        self.setLeftReturnIcon();
        self.progressView = UIProgressView(progressViewStyle: .Bar);
        self.view.addSubview(self.progressView);
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil);
        
        if let link = self.webLink{
            self.webURL = NSURL(string:link);
        }
        if let url = self.webURL {
            self.webView.loadRequest(NSURLRequest(URL: url));
        }
        else
        {
            self.showAlertMessage("网络地址错误", clickedAction: nil);
        }
    }
    override func leftItemAction(sender: AnyObject!) {
        self.navigationController?.popViewControllerAnimated(true);
        self.webView.stopLoading();
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        if (self.showToolBar == true) {
            self.navigationController?.toolbarItems = nil;
            self.navigationController?.toolbarHidden = true;
        }
    }
    func panAction(pan:UIPanGestureRecognizer)
    {
        switch pan.state
        {
        case .Began:break;
        case .Ended:
            let velocity  = pan.velocityInView(self.view)
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
            let offsetPoint = pan.translationInView(self.view);
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
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        self.hideWaiting();
        self.navigationItem.title=webView.title;
        self.updateToolbarItems();
    }
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        self.hideWaiting();
        if (error.code==NSURLErrorTimedOut||error.code==NSURLErrorNotConnectedToInternet) {
            self.showAlertMessage("无法打开网页请检查网络设置\n然后点击屏幕重试",clickedAction:nil);
        }
        self.updateToolbarItems();
    }
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showWaitingActivity();
        self.updateToolbarItems();
    }
    func updateToolbarItems()
    {
        if self.showToolBar
        {
            self.backBarButtonItem.enabled=self.webView.canGoBack;
            self.forwardBarButtonItem.enabled=self.webView.canGoForward;
            let fixedSide = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil);
            fixedSide.width = 5;
            let fixedMiddle = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil);
            
            self.toolbarItems = [fixedSide,self.backBarButtonItem,fixedMiddle,self.refreshBarButtonItem,fixedMiddle,self.forwardBarButtonItem,fixedSide];
        }
    }
    //#mark kvo
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress"
        {
            let newprogress = self.webView.estimatedProgress;
            if (newprogress == 1) {
                self.progressView.hidden = true;
                self.progressView.setProgress(0, animated: false);
            }else {
                self.progressView.hidden = false;
                self.progressView.setProgress(Float(newprogress), animated: true)
            }
        }
    }
}
