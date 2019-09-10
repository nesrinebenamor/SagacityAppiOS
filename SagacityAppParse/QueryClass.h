//
//  QueryClass.h
//  SagacityAppParse
//
//  Created by ESPRIT on 26/12/2015.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <Parse/PFObject.h>

@interface QueryClass : NSObject

+ (void) getQuote:(void (^)(NSArray *))completion;
+ (void) getAuthor:(void (^)(NSArray *))completion;


@end
