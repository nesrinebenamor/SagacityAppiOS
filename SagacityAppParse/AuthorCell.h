//
//  AuthorCell.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/30/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;

@property (weak, nonatomic) IBOutlet UITextView *nameAuthor;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end
