//
//  MbyShowHtmlController.m
//  eVHC
//
//  Created by Mobiyun on 2017/11/13.
//  Copyright © 2017年 Mobiyun. All rights reserved.
//

#import "MbyShowHtmlController.h"

#import <WebKit/WebKit.h>
#import "ArchiveManager.h"
#import "ZipArchiveManager.h"
#import "WebViewJavascriptBridge.h"
#import "WKWebViewJavascriptBridge.h"
#import "AppDelegate.h"
#import "NSUserDefaultsKeys.h"
#import "Category.h"

@interface MbyShowHtmlController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler, UIAlertViewDelegate,UIWebViewDelegate>

@property (nonatomic, weak) WKWebView *m_webView;
@property  (nonatomic, strong) WebViewJavascriptBridge *bridge;

@property (copy, nonatomic) NSString *m_appVer;
/**
 本地默认版本号
 */
@property (copy, nonatomic) NSString *m_appHtmlVer;
/**
 检查后的最新HTML版本号
 */
@property (copy, nonatomic) NSString *m_newHtmlVer;
@property (copy, nonatomic) NSString *m_msg;
@property (assign, nonatomic) NSInteger m_status;
@property (copy, nonatomic) NSString *m_appDownUrl;


@end

@implementation MbyShowHtmlController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.bridge) return;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *local_ver = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.m_appHtmlVer = [NSString ex_stringWithId:M_USERDEFAULTS_GET(HTML_VERSION)];
    
    [self checkVersion:local_ver];


    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    
    configuration.userContentController = userContentController;
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.javaScriptEnabled = true;
    preferences.minimumFontSize = 0.0;
    configuration.preferences = preferences;
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    webView.scrollView.bounces = false;
    webView.tag = WebViewTagShowHtml;
    self.m_webView = webView;
    
    [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://10.0.1.137:8877/#/login"]]];
    [self.view addSubview:self.m_webView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:true];
}


- (void)loadExamplePage:(WKWebView*)webView url:(NSString *)url{
    
    url = [@"file://" stringByAppendingString:url];
    NSURL *fileURL = [[NSURL alloc]initWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"html--Url%@",fileURL);
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [webView loadRequest:request];
}



#pragma mark WKWebView WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidStartLoad");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{

    NSLog(@"%@",error);
    [self.m_webView reload];
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{

    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    if (webView.tag == WebViewTagAppDown) {
        NSLog(@"webViewDidFinishLoad -- 下载APP");
    }
    if (webView.tag == WebViewTagShowHtml) {
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *local_ver = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *js = [NSString stringWithFormat:@"getVersion('%@','%@')",local_ver, self.m_appHtmlVer];
        [self.m_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"result---%@",result);
            NSLog(@"error----%@",error);
        }];
        NSLog(@"webViewDidFinishLoad -- 显示HTML");
    }
}


#pragma mark WKWebView WKUIDelegate

- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {

    completionHandler();

    NSLog(@"----%@----", message);
}


#pragma mark AlertDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
        
            NSString *js = [NSString stringWithFormat:@"updateApp('%@')", self.m_appDownUrl];
            [self.m_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                NSLog(@"result---%@",result);
                NSLog(@"error----%@",error);
            }];
            
        }else{
            [self checkHtmlVer];
        }
    }
    if (alertView.tag == 2) {
        NSString *js = [NSString stringWithFormat:@"updateApp('%@')", self.m_appDownUrl];
        [self.m_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"result---%@",result);
            NSLog(@"error----%@",error);
        }];
    }
}



#pragma mark 检测版本更新
- (void)checkVersion:(NSString *)appVer{
    
    WS
    [[ArchiveManager manager] setArrayBlock:^(NSDictionary *result, NSString *filePath, NSFileManager *manager){
        
        NSLog(@"%@",result);
        NSDictionary *evhc_ios = result[@"evhc_ios"];
        ws.m_status = [NSString ex_integerWithId:evhc_ios[@"status"]];
        ws.m_msg = [NSString ex_stringWithId:evhc_ios[@"msg"]];
        ws.m_appVer = [NSString ex_stringWithId:evhc_ios[@"appVer"]];
        ws.m_appDownUrl = [NSString ex_stringWithId:evhc_ios[@"url"]];
        ws.m_newHtmlVer = [NSString ex_stringWithId:evhc_ios[@"appVerHtml"]];
        
        [manager removeItemAtPath:filePath error:nil];
        
        if (![appVer isEqualToString:ws.m_appVer]) {
            if (ws.m_status == 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:ws.m_msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                alert.tag = 1;
                [alert show];
            }
            if (ws.m_status == 1) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:ws.m_msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 2;
                [alert show];
            }
        }else{
        //检查本地HTML版本
            [self checkHtmlVer];
        }
     
    }];
    
    [[ArchiveManager manager] startRequest:[NSString ex_setTimeSpUrl:DOWN_VERSION_JSON]];
}

- (void)checkHtmlVer{
    
    NSString *html_local_ver = NSTemporaryDirectory();
    html_local_ver = [html_local_ver stringByAppendingPathComponent:self.m_newHtmlVer];
    
    if ([NSString ex_directoryExists:html_local_ver fileManager:[NSFileManager defaultManager]]) {
        NSLog(@"不需要更新本地HTML");
//        [self.m_webView reload];
        
    }else{
        NSLog(@"更新本地HTML");
        WS
        [[ZipArchiveManager manager] setArrayBlock:^(NSString *hostPath, NSArray *nameArray, NSFileManager *fileManager){
            
            [self clearWbCache];
            NSString *htmlPath = [hostPath stringByAppendingPathComponent:@"index.html"];
            M_USERDEFAULTS_SET(htmlPath, WEB_VIEW_URL);
            M_USERDEFAULTS_SET(ws.m_newHtmlVer, HTML_VERSION);
            ws.m_appHtmlVer = ws.m_newHtmlVer;
            [ws loadExamplePage:ws.m_webView url:htmlPath];
            [ws clearOtherFileName:fileManager];
            
        }];
        [[ZipArchiveManager manager] startRequest:[NSString ex_setTimeSpUrl:DOWN_HTML_URL] htmlVer:self.m_newHtmlVer];
    }
}



/**
 清除temp目录下的多余HTML文件包

 @param fileManager 文件管理
 */
- (void)clearOtherFileName:(NSFileManager *)fileManager{

    NSArray *fileList = [NSArray ex_fileList:NSTemporaryDirectory()];
    [fileList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:self.m_newHtmlVer]) {
            NSArray *fileNames = [obj componentsSeparatedByString:@"."];
            if ([fileNames count] == 3 && [[fileNames lastObject] length] == 1) {
                NSLog(@"删除文件--%@",obj);
                NSString *fileName = [NSTemporaryDirectory() stringByAppendingPathComponent:obj];
                [fileManager removeItemAtPath:fileName error:nil];
            }
        }
    }];

}


/**
 清理缓存
 */
- (void)clearWbCache {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}


#pragma mark 检测网络状态
-(BOOL)checkNetwork{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *currentNetFlag = M_USERDEFAULTS_GET(NET_WORK_STATUS);
    if([currentNetFlag isEqualToString:@"0"]) {
        [delegate showTextOnly:@"网络不给力，请稍后再试"];
        return NO;
    }else{
        return YES;
    }
    return YES;
}

- (void)exitApplication {
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

- (void)loadAppDownLoad:(NSString *)url{

    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.minimumFontSize = 10;
    config.preferences.javaScriptEnabled = true;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:CGRectZero configuration:config];
    webView.navigationDelegate = self;
    webView.scrollView.bounces = false;
    webView.tag = WebViewTagAppDown;
    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [webView loadRequest:req];
}



@end
