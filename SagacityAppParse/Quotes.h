//
//  Quotes.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 12/30/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Quotes : NSObject

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *category;

@property (strong, nonatomic) NSString *idAuthor;
@property (strong, nonatomic) NSString *idQuote;

@property (strong, nonatomic) UIImage *imgQuote;
@property (nonatomic) NSInteger nbVote;
@property (nonatomic) float rate;



-(instancetype)initwithid:(NSString *)idQuote withcontent:(NSString*)content withcategory:(NSString*)category withimage:(UIImage*) imgquote theauthor:(NSString *)idAuthor rated:(float)rate withnumberofvote:(NSInteger)nbvote;


@end
