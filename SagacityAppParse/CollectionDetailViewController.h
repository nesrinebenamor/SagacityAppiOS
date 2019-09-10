//
//  CollectionDetailViewController.h
//  YSLTransitionAnimatorDemo
//
//  Created by yamaguchi on 2015/05/20.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "UIPopoverListView.h"

@interface CollectionDetailViewController : UIViewController<UIPopoverListViewDataSource, UIPopoverListViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *titre;
@property (strong) DBManager* DB;

@property(weak,nonatomic) NSString* titreString;

@property (nonatomic, strong) NSData *imgData;

@property(weak,nonatomic) NSString* color;


@end
