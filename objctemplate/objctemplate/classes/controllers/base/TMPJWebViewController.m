//
//  TMPJWebViewController.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJWebViewController.h"

@interface TMPJWebViewController ()<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>
@property (nonatomic)BOOL showToolBar;
@property (nonatomic, strong,readwrite)WKWebView *webView;
@property (nonatomic, strong) NSURL *webURL;
@property (nonatomic ,strong) UIProgressView * progressView;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *refreshBarButtonItem;
@end

@implementation TMPJWebViewController
- (void)dealloc
{
    self.webView.UIDelegate=nil;
    self.webView.navigationDelegate=nil;
}
- (instancetype)initWithLink:(NSString *)weblink showToolBar:(BOOL)showToolBar
{
    self = [super init];
    if (self) {
        self.webURL = [NSURL URLWithString:weblink];
        self.showToolBar=showToolBar;
    }
    return self;
}
-(WKWebView *)webView
{
    if (!_webView) {
        WKWebView *webView=[[WKWebView alloc] initWithFrame:self.view.bounds];
        [webView.scrollView.panGestureRecognizer addTarget:self action:@selector(panAction:)];
        webView.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        webView.navigationDelegate=self;
        webView.UIDelegate=self;
        self.webView=webView;
    }
    return _webView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.showToolBar) {
        self.navigationController.toolbarItems = nil;
        self.navigationController.toolbarHidden = YES;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.webView];
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    [self.view addSubview:self.progressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self setLeftReturnIcon];
    if (self.webURL)
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.webURL]];
    }
    else
    {
        [self showAlertMessage:@"网络地址错误" clickedAction:nil];
    }
    if (self.showToolBar) {
        [self updateToolbarItems];
        [self.navigationController setToolbarHidden:NO];
    }
}
-(void)leftItemAction:(id)sender
{
    [super leftItemAction:sender];
    [self.webView stopLoading];
}
#pragma mark WKWebViewDelegate
-(void)panAction:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
        }break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint velocity = [pan velocityInView:self.view];
            if (velocity.y<0)
            {
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                if (self.showToolBar) {
                    [self.navigationController setToolbarHidden:YES animated:YES];
                }
                [self setNeedsStatusBarAppearanceUpdate];
            }
            else if (velocity.y>600||self.webView.scrollView.contentOffset.y<=10)
            {
                [self.navigationController setNavigationBarHidden:NO animated:YES];
                if (self.showToolBar) {
                    [self.navigationController setToolbarHidden:NO animated:YES];
                }
                [self setNeedsStatusBarAppearanceUpdate];
            }
        }break;
        default:
        {
            CGPoint offsetPoint = [pan translationInView:self.view];
            if (offsetPoint.y<0)
            {
                
                CGFloat offsety = offsetPoint.y*0.1;
                CGFloat top =self.navigationController.toolbar.top;
                CGFloat barTop = top-offsety;
                if (barTop>self.view.bottom) {
                    barTop=self.view.bottom;
                }
                self.navigationController.toolbar.top = barTop;
            }
        }break;
    }
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self hideWaiting];
    self.navigationItem.title=webView.title;
    [self updateToolbarItems];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self hideWaiting];
    if (error.code==NSURLErrorTimedOut||error.code==NSURLErrorNotConnectedToInternet) {
        [self showAlertMessage:@"无法打开网页请检查网络设置\n然后点击屏幕重试" clickedAction:nil];
    }
    [self updateToolbarItems];
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self showWaitingActivity];
    [self updateToolbarItems];
}
#pragma mark - Toolbar

- (void)updateToolbarItems {
    if (self.showToolBar) {
        self.backBarButtonItem.enabled = self.webView.canGoBack;
        self.forwardBarButtonItem.enabled = self.webView.canGoForward;
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpace.width = 5.0f;
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self.toolbarItems = @[fixedSpace,self.backBarButtonItem,flexibleSpace,self.refreshBarButtonItem,flexibleSpace,self.forwardBarButtonItem,fixedSpace];
    }
}
- (UIBarButtonItem *)backBarButtonItem {
    
    if (!_backBarButtonItem) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage arrowWithDirection:ETArrowImageDirectionLeft] style:UIBarButtonItemStylePlain target:self action:@selector(goBackClicked:)];
        item.width = 18.0f;
        self.backBarButtonItem = item;
        
    }
    return _backBarButtonItem;
}

- (UIBarButtonItem *)forwardBarButtonItem {
    
    if (!_forwardBarButtonItem) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage arrowWithDirection:ETArrowImageDirectionRight] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardClicked:)];
        item.width = 18.0f;
        self.forwardBarButtonItem = item;
    }
    return _forwardBarButtonItem;
}

- (UIBarButtonItem *)refreshBarButtonItem {
    
    if (!_refreshBarButtonItem) {
        self.refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadClicked:)];
    }
    return _refreshBarButtonItem;
}
- (void)goBackClicked:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (void)goForwardClicked:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

- (void)reloadClicked:(UIBarButtonItem *)sender {
    [self.webView reload];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}
@end
