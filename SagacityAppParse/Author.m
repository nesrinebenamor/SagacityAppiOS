//
//  Author.m
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 12/30/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "Author.h"

@implementation Author


-(instancetype)initwithid:(NSString *)idAuthor withname:(NSString *)name withimage:(UIImage *)authorimg
{
    _idAuthor = idAuthor;
    _nameAuthor=name;
    _imgAuthor=authorimg;
    
    return self;
}
@end
