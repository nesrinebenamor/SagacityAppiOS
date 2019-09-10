//
//  QuoteWidget.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 12/7/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface QuoteWidget : NSObject

@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *source;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

- (void)getQuote:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

@end
