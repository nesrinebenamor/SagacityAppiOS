//
//  QuoteDetailViewController.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 12/6/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "UIPopoverListView.h"
#import <Parse/PFFile.h>
#import "EDStarRating.h"
#import "Popup.h"
#import <Parse/Parse.h>

@interface QuoteDetailViewController : UIViewController<UITabBarDelegate,UIPopoverListViewDataSource, UIPopoverListViewDelegate,EDStarRatingProtocol>

@property (weak, nonatomic) IBOutlet UITextView *authorName;

@property (weak, nonatomic) IBOutlet UITextView *quoteContent;
@property (weak, nonatomic) IBOutlet UIImageView *quoteImage;

@property(weak,nonatomic) NSString* titreString;

@property(weak,nonatomic) NSString* idObj;

@property(weak,nonatomic) NSString* color;


@property (nonatomic, strong) NSData *imgData;

@property (nonatomic, strong) UIImage *imgQuote;

@property (strong, nonatomic) EDStarRating *starRating;


@property (strong) DBManager* DB;

@end
