//
//  FavorisViewController.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 12/7/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "REFrostedViewController.h"

@interface FavorisViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tab;
@property (strong,nonatomic) NSArray* myarray;

@property(strong,nonatomic) DBManager* DB;

-(void) loaddata;
- (IBAction)showMenu:(id)sender;

@end
