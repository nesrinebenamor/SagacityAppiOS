//
//  FTEntry.h
//  SagacityApp
//
//  Created by Nessrine Ben Amor on 11/26/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FT_STORE_THUMBNAIL_ONLY

@interface FTEntry : NSObject

@property (nonatomic, assign) BOOL loaded;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSData *data;

@end
