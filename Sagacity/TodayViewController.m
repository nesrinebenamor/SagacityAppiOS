//
//  TodayViewController.m
//  Sagacity
//
//  Created by Nessrine Ben Amor on 12/7/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [self showRandomQuote];
    [self.quoteText addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}


- (void)setQuoteSting:(NSString*)quoteSting
{
    
    
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"“’abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-"".!?*@,;/;' "];
    
    
    NSString *firstWord = [[quoteSting componentsSeparatedByString:@" "] objectAtIndex:0];
    
    s = [s invertedSet];
    
    NSLog(@"FIrst Word %@",firstWord);
    NSRange r = [firstWord rangeOfCharacterFromSet:s];
    
    if (r.location != NSNotFound) {
        NSLog(@"the quote is chineese");
        [self showRandomQuote];
        
    }
    else
    {NSLog(@"the quote is english");
        _quoteSting = quoteSting;
        self.quoteText.text = quoteSting;}
    
    
    
}

- (void)showRandomQuote
{
    QuoteWidget *quote = [[QuoteWidget alloc] init];
    
    
    [quote getQuote:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.quoteSting = [NSString stringWithFormat:@"“%@” ― %@",
                           responseObject[@"body"],
                           responseObject[@"author"]];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UITextView *tv = object;
    CGFloat topCorrect = ([tv bounds].size.height - [tv contentSize].height * [tv zoomScale]) / 2.0;
    topCorrect = (topCorrect < 0.0 ? 0.0 : topCorrect);
}


@end
