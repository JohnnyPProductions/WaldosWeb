//
//  ViewController.m
//  WaldosWeb
//
//  Created by Johnny Parizek on 12/27/14.
//  Copyright (c) 2014 Johnny Parizek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property NSString *www;
@property NSString *com;
@property NSString *http;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Waldo's Web";
    [self loadHomePage];
    self.www = @"www.";
    self.com = @".com";
    self.http = @"http://";
     self.webView.scrollView.delegate = self;
    
}

- (void)loadURLString: (NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];

}

- (void)loadHomePage
{
    NSString *homePage = @"http://www.google.com" ;
    [self checkAndLoadURLString:homePage];
}

- (void)checkAndLoadURLString:(NSString *)webAddress
{
    
     if ([webAddress containsString:@"http://"] && [webAddress containsString:@"www."] && [webAddress containsString:@".com"])
     {
         [self loadURLString:webAddress];
     }
    
     else if ([webAddress containsString:@"http://"] && [webAddress containsString:@"www."])
     {
         NSString *url = [NSString stringWithFormat:@"%@%@",webAddress,self.com];
         self.textField.text = url;
         [self loadURLString:url];
     }
     else if ([webAddress containsString:@"www."] && [webAddress containsString:@".com"])
     {
         NSString *url = [NSString stringWithFormat:@"%@%@",self.http,webAddress];
         self.textField.text = url;
         [self loadURLString:url];
     }
     else if ([webAddress containsString:@"www."])
    {
        NSString *url = [NSString stringWithFormat:@"%@%@%@",self.http,webAddress,self.com];
        self.textField.text = url;
        [self loadURLString:url];
    }
     else if ([webAddress containsString:@".com"])
     {
         NSString *url = [NSString stringWithFormat:@"%@%@%@",self.http,self.www,webAddress];
         self.textField.text = url;
         [self loadURLString:url];
     }
    
    else
    {
        NSString *url = [NSString stringWithFormat:@"https://www.google.com/#q=%@",webAddress];
        self.textField.text = url;
        [self loadURLString:url];    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (IBAction)goClicked:(id)sender
{
    
    NSString *webPage = self.textField.text;
    if ([webPage isEqual: @"waldo"] || [webPage isEqual: @"Waldo"])
    {
        [self performSegueWithIdentifier:@"Waldo" sender:self];
    }
    [self checkAndLoadURLString:webPage];
}

@end

