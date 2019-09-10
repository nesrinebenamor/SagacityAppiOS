//
//  LoadingView.h
//  LoadingView
//
//  Created by Matt Gallagher on 12/04/09.
//  Copyright Matt Gallagher 2009. All rights reserved.
// 
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//
//  Additions and tweaks by Shazron Abdullah, Nitobi Software.
//


// *** Needs QuartzCore.framework
#import <UIKit/UIKit.h>

@protocol LoadingViewDelegate
- (void)cancelLoadingView;
@end

@interface LoadingView : UIView
{
	NSTimeInterval minDuration;
	NSDate* timestamp;
	CGFloat boxLength;
	CGFloat backgroundOpacity;
	CGFloat strokeOpacity;
	UIColor* strokeColor;
	BOOL fullScreen;
	UILabel* textLabel;
	BOOL bounceAnimation;
}

@property (nonatomic, assign) CGFloat boxLength;
@property (nonatomic, assign) CGFloat backgroundOpacity;
@property (nonatomic, assign) CGFloat strokeOpacity;
@property (nonatomic, retain) UIColor* strokeColor;
@property (nonatomic, assign) NSTimeInterval minDuration;
@property (nonatomic, retain) NSDate* timestamp;
@property (nonatomic, assign) BOOL fullScreen;
@property (nonatomic, retain) UILabel* textLabel;
@property (nonatomic, assign) BOOL bounceAnimation;
@property (nonatomic, strong) UIButton* cancelButton;


@property (weak, nonatomic) id delegate;

+(void) showLoadingViewinView: (UIView *) showView withLabel: (NSString *) label delegate:(id) delegate;
+(void) showLoadingViewinView: (UIView *) showView withLabel: (NSString *) label;
- (void)removeView;
+(void) removeLoadingView;
-(void) cancelLoadingView;

+(void) hideCancelButton;
+(void) showCancelButton:(NSString *)text;

@end
