//
//  TodayViewController.h
//  SagacityDailyQuote
//
//  Created by Nessrine Ben Amor on 12/30/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *quoteString;

@property (weak, nonatomic) NSString *quote;

@end
