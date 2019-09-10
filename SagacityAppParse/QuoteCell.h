//
//  QuoteCell.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/30/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *quoteImage;
@property (weak, nonatomic) IBOutlet UIImageView *qImg;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end
