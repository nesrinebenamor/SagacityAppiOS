//
//  Quote.m
//  SagacityApp
//
//  Created by Nessrine Ben Amor on 11/22/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "Quote.h"
#import "AFHTTPRequestOperationManager.h"
static NSString * const RandomQuotesAPIBaseURLString = @"https://random-quotes.herokuapp.com/";

@implementation Quote

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.body = [attributes valueForKeyPath:@"body"];
    self.author = [attributes valueForKeyPath:@"author"];
    //self.source = [attributes valueForKeyPath:@"source"];
    
    return self;
}

- (void)getQuote:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:RandomQuotesAPIBaseURLString
      parameters:nil
         success:success
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"Error: %@", error);
         }];
}


@end
