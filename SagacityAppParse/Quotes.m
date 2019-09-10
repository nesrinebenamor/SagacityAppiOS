//
//  Quotes.m
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 12/30/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "Quotes.h"

@implementation Quotes


-(instancetype)initwithid:(NSString *)idQuote withcontent:(NSString *)content withcategory:(NSString *)category withimage:(UIImage *)imgquote theauthor:(NSString *)idAuthor rated:(float)rate withnumberofvote:(NSInteger)nbvote{
    
    _idQuote=idQuote;
    _idAuthor=idAuthor;
    _imgQuote=imgquote;
    _rate=rate;
    _nbVote=nbvote;
    _content=content;
    _category=category;
    
    return self;
}
@end
