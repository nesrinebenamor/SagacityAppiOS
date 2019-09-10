//
//  Quote.h
//  SagacityApp
//
//  Created by Nessrine Ben Amor on 11/22/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "PrefixHeader.pch"


@interface Quote : NSObject
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *source;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

- (void)getQuote:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

@end
