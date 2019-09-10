//
//  MenuNavigationController.m
//  SagacityApp
//
//  Created by Nessrine Ben Amor on 11/22/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "MenuNavigationController.h"
#import "MenuSlideViewController.h"



@interface MenuNavigationController ()

@end

@implementation MenuNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}



@end
