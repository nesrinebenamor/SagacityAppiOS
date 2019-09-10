//
//  QueryClass.m
//  SagacityAppParse
//
//  Created by ESPRIT on 26/12/2015.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "QueryClass.h"


@implementation QueryClass

+ (void) getQuote:(void (^)(NSArray *))completion {
    
    // your query code.  let's assume this is fine
        
    
    
    PFQuery *query=[PFQuery queryWithClassName:@"Quotes"];
    [query selectKeys:@[@"image",@"content"]];
   
    [query findObjectsInBackgroundWithBlock:^(NSArray *  objects, NSError *  error)
     {

         if (!error) {
             // the job is MUCH simpler here than your code supposed.
             // log the result for fun
             NSLog(@"did we get objects? %@", objects);
             
             // hand it back to the caller
             // notice there's no array kept in this class.  it's not needed
             // and it would be awkward to do it at the class (not instance) level
             completion(objects);
         } else {
             NSLog(@"bad news from parse: %@", error);
             completion(nil);
         }
         
     }];
}

+ (void) getAuthor:(void (^)(NSArray *))completion {
    
    // your query code.  let's assume this is fine
    
    PFQuery *query=[PFQuery queryWithClassName:@"Authors"];
    [query selectKeys:@[@"image",@"Name"]];

    
    [query findObjectsInBackgroundWithBlock:^(NSArray *  objects, NSError *  error)
     {
         
         if (!error) {
             // the job is MUCH simpler here than your code supposed.
             // log the result for fun
             NSLog(@"did we get objects? %@", objects);
             
             // hand it back to the caller
             // notice there's no array kept in this class.  it's not needed
             // and it would be awkward to do it at the class (not instance) level
             completion(objects);
         } else {
             NSLog(@"bad news from parse: %@", error);
             completion(nil);
         }
         
     }];
}


@end
