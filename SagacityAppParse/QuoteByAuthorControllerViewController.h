//
//  QuoteByAuthorControllerViewController.h
//  SagacityAppParse
//
//  Created by ESPRIT on 14/12/2015.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface QuoteByAuthorControllerViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *authorsImages;
    NSArray *imagesFilesArray;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *quotesCollections;
@property (weak, nonatomic) IBOutlet UIImageView *author;

@property(nonatomic,weak) NSString *idAuthor;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property(nonatomic,weak) UIImage *authorImg;

@property(nonatomic,weak) NSData *img;

@property(nonatomic,weak) PFFile *imFile;
@property (nonatomic) BOOL isParsed;


@end
