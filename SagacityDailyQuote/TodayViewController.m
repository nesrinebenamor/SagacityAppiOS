//
//  TodayViewController.m
//  SagacityDailyQuote
//
//  Created by Nessrine Ben Amor on 12/30/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "AFNetworking.h"
#import "Quote.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController


- (void)setQuoteSting:(NSString*)quoteSting
{
    
    
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"“’abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-"".!?*@,;/;' "];
    
    
    NSString *firstWord = [[quoteSting componentsSeparatedByString:@" "] objectAtIndex:0];
    
    s = [s invertedSet];
    
    NSLog(@"FIrst Word %@",firstWord);
    NSRange r = [firstWord rangeOfCharacterFromSet:s];
    
    if (r.location != NSNotFound) {
        NSLog(@"the quote is chineese");
  //      [self showRandomQuote];
        
    }
    else
    {NSLog(@"the quote is english");
        _quote = quoteSting;
        self.quoteString.text = quoteSting;}
    
}


- (void)showRandomQuote
{
    Quote *quote = [[Quote alloc] init];
    
    
    [quote getQuote:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.quoteSting = [NSString stringWithFormat:@"“%@” ― %@",
                           responseObject[@"body"],
                           responseObject[@"author"]];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showRandomQuote];
     self.quoteString.text=@"";

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

@end
