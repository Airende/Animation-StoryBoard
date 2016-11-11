//
//  D_bViewController.m
//  StoryboardDome
//
//  Created by airende on 2016/10/31.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "D_bViewController.h"

@interface D_bViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView * wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;//进度条

@end

@implementation D_bViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    // web内容处理池，由于没有属性可以设置，也没有方法可以调用，不用手动创建
    config.processPool = [[WKProcessPool alloc] init];
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    //初始化WKWebView与UIWebView类似，多添加了一个配置的参数方法
    _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://h5.myweimai.com/share/article.html?aid=910700000019041907&type=mobile"]]];
    
    [self.view addSubview:_wkWebView];
    
    
    [_wkWebView setAllowsBackForwardNavigationGestures:true];

    //进度条的创建
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 0);
    _progressView.tintColor = [UIColor greenColor];//加载颜色
    _progressView.trackTintColor = [UIColor whiteColor];//未加载颜色

    [self.view addSubview:_progressView];
    
   // 通过监听estimatedProgress可以获取它的加载进度 还可以监听它的title ,URL, loading,scrollView.contentSize等
    [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
     [_wkWebView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    
    
}

//- (WKNavigation *)goToBackForwardListItem:(WKBackForwardListItem *)item{
    
    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - make WKNavigationDelegate
///用来追踪加载过程（页面开始加载、加载完成、加载失败）的方法
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"当前方法名：%s",__func__);
    NSLog(@"当前方行数：%d",__LINE__);
    NSLog(@"当前方路径：%s",__FILE__);

}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"当前方法名：%s",__func__);
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"当前方法名：%s",__func__);
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"当前方法名：%s",__func__);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{

}

///页面跳转的代理方法
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{

}

/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    //    NSLog(@"%@",navigationResponse.response);
    
    // 如果响应的地址是百度，则允许跳转
    //    if ([navigationResponse.response.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
    //
    //        // 允许跳转
    //        decisionHandler(WKNavigationResponsePolicyAllow);
    //        return;
    //    }
    //    // 不允许跳转
    //    decisionHandler(WKNavigationResponsePolicyCancel);
    decisionHandler(WKNavigationResponsePolicyAllow);
}
/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
        && ![hostname containsString:@".baidu.com"]) {
        // 对于跨域，需要手动跳转
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        
        // 不允许web内跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        self.progressView.alpha = 1.0;
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    NSLog(@"%s", __FUNCTION__);
}

// 9.0才能使用，web内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}


// 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

- (void)dealloc{
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma - mark WKUIDelegate
///这个协议主要用于WKWebView处理web界面的三种提示框(警告框、确认框、输入框)，下面是警告框的例子
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
// 在JS端调用alert函数时，会触发此代理方法。
// JS端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调JS，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:@"JS调用alert" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);

}

// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:@"JS调用confirm" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"%@", message);
}

// JS端调用prompt函数时，会触发此方法
// 要求输入一段文本
// 在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    NSLog(@"%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"loading"]) {
        
        // 加载完成
        if (!self.wkWebView.loading) {
            // 手动调用JS代码
            // 每次页面完成都弹出来，大家可以在测试时再打开
            NSString *js = @"callJsAlert()";
            [self.wkWebView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                NSLog(@"response: %@ error: %@", response, error);
                NSLog(@"call js alert by native");
            }];
            
            NSString *jsData = @"calltoValue('参数')";
            [self.wkWebView evaluateJavaScript:jsData completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                NSLog(@"response: %@ error: %@", response, error);
                NSLog(@"------->call js alert by native");
            }];
            
            
            [UIView animateWithDuration:0.5 animations:^{
                self.progressView.alpha = 0;
            }];
        }
        
    } else if ([keyPath isEqualToString:@"title"]) {
        self.title = _wkWebView.title;
    } else if ([keyPath isEqualToString:@"URL"]) {
        
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progressView.progress = self.wkWebView.estimatedProgress;
    }
    
    //不要让进度条倒着走...有时候goback会出现这种情况
    if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
        return;
    }
    
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
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

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_0
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}
#endif

// 创建一个新的WebView（标签带有 target='_blank' 时，导致WKWebView无法加载点击后的网页的问题。）
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // 接口的作用是打开新窗口委托
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

// 从web界面中接收到一个脚本时调用 回调
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"AppModel"]) {
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        // NSDictionary, and NSNull类型
        NSLog(@"======>%@", message.body);
    }
}

@end
