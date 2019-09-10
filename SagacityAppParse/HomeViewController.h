//
//  HomeViewController.h
//  SagacityApp
//
//  Created by Nessrine Ben Amor on 11/22/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import <Parse/Parse.h>
#import "Reachability.h"
#import "Quotes.h"

@interface HomeViewController : UIViewController<UICollectionViewDelegate,
UICollectionViewDataSource,UIScrollViewDelegate>
{
    NSMutableArray *authorsImages;
    NSArray *imagesFilesArray;
    NSArray *contentArray;



}
@property (weak, nonatomic) IBOutlet UIView *viewNotification;
@property (weak, nonatomic) IBOutlet UILabel *notif;

- (IBAction)showMenu:(id)sender;
- (void)showRandomQuote;

@property (weak, nonatomic) IBOutlet UILabel *mylabel;

@property(weak,nonatomic) NSString *myselection;
@property(weak,nonatomic) NSData *datatotestwith;

@property(nonatomic,strong) Quotes *q;

@property (weak, nonatomic) IBOutlet UITextView *quoteText;
@property (strong, nonatomic) NSString *quoteSting;
@property (strong, nonatomic) IBOutlet UIImageView *back;

@property (nonatomic,strong) UICollectionView *quotesCollections;
@property (weak, nonatomic) IBOutlet UIImageView *test;


@property (nonatomic, retain) Reachability* reachability;

@property (weak,nonatomic) NSString *mood;
@property (nonatomic) BOOL isParsed;
@property (weak, nonatomic) IBOutlet UIButton *moodBtn;

@end
