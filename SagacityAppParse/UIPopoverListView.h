//
//  UIPopoverListView.h
//  UIPopoverListViewDemo
//
//  Created by su xinde on 13-3-13.
//  Copyright (c) 2013年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@class UIPopoverListView;

@protocol UIPopoverListViewDelegate <NSObject>
@optional

- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath;

- (void)popoverListViewCancel:(UIPopoverListView *)popoverListView;

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol UIPopoverListViewDataSource <NSObject>
@required

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section;

@end

@interface UIPopoverListView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_listView;
    UILabel     *_titleView;
    UIControl   *_overlayView;
    
    id<UIPopoverListViewDataSource> datasource;
    id<UIPopoverListViewDelegate> delegate;

}

@property (nonatomic, assign) id<UIPopoverListViewDataSource> datasource;
@property (nonatomic, assign) id<UIPopoverListViewDelegate>   delegate;

@property (nonatomic, retain) UITableView *listView;

- (void)setTitle:(NSString *)title;

- (void)show;
- (void)dismiss;

@end





