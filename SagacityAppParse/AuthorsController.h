//
//  AuthorsController.h
//  SagacityApp
//
//  Created by Nessrine Ben Amor on 11/23/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "AuthorCell.h"
#import <Parse/Parse.h>

@interface AuthorsController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
NSMutableArray *authorsImages;
    NSArray *imagesFilesArray;
}
- (IBAction)showMenu:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *authorsCollection;
@property (weak, nonatomic) IBOutlet UIImageView *back;


@end
