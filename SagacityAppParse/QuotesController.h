//
//  QuotesController.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/30/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface QuotesController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *authorsImages;
    NSArray *imagesFilesArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *quotesCollections;

- (IBAction)showMenu:(id)sender;
@property (nonatomic) BOOL isParsed;

@property (weak, nonatomic) IBOutlet UIImageView *back;

@end
