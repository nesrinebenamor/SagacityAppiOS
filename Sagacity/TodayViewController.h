//
//  TodayViewController.h
//  Sagacity
//
//  Created by Nessrine Ben Amor on 12/7/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuoteWidget.h"
@interface TodayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *quoteText;

@property (strong, nonatomic) NSString *quoteSting;

@end
