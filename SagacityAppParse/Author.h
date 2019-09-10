//
//  Author.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 12/30/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Author : NSObject
@property (strong, nonatomic) NSString *nameAuthor;
@property (strong, nonatomic) NSString *idAuthor;
@property (strong, nonatomic) UIImage *imgAuthor;


//constructeur
-(instancetype)initwithid:(NSString *)idAuthor withname:(NSString*)name withimage:(UIImage*) authorimg;

@end
