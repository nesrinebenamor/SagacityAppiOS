//
//  MoodMenu.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/28/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAShareBubbles.h"

@interface MoodMenu : UIViewController <AAShareBubblesDelegate>

@property (weak, nonatomic) IBOutlet UIButton *moodButton;
- (IBAction)mood:(id)sender;
@property (weak,nonatomic) NSString *mood;
@property (nonatomic) NSInteger idMood;

@property (weak, nonatomic) IBOutlet UIImageView *back; //background
- (IBAction)homeAction:(id)sender;
@end
