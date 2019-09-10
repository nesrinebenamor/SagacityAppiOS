//
//  MenuSlideViewController.m
//  SagacityApp
//
//  Created by Nessrine Ben Amor on 11/22/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "MenuSlideViewController.h"
#import "HomeViewController.h"
//#import "CategoriesViewController.h"
#import "MenuNavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "AuthorsController.h"
#import "CollectionViewController.h"
#import "LoginViewController.h"
#import "QuotesController.h"
#import "FavorisViewController.h"


@interface MenuSlideViewController ()

@end

@implementation MenuSlideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _loadData];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _imageView.image = [UIImage imageNamed:@"guest.png"];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 50.0;
        _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageView.layer.borderWidth = 3.0f;
        _imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _imageView.layer.shouldRasterize = YES;
        _imageView.clipsToBounds = YES;
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        _label.text = @"Guest";
        _label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [_label sizeToFit];
       _label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:_imageView];
        [view addSubview:_label];
        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
   // label.text = @"Friends Online";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
        navigationController.viewControllers = @[homeViewController];
    }
    

    else if (indexPath.section == 1 && indexPath.row == 0) {
        AuthorsController *authorsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"authorsController"];
        navigationController.viewControllers = @[authorsViewController];
    }
    
    else {
      CategoriesViewController   *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"secondController"];
        navigationController.viewControllers = @[secondViewController];
    }
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    */
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
        navigationController.viewControllers = @[homeViewController];
    }
    else if(indexPath.section == 0 && indexPath.row == 1){
        CollectionViewController *vc = [[CollectionViewController alloc]initWithNibName:@"CollectionViewController" bundle:nil];
       navigationController.viewControllers=@[vc];
    }
    else if(indexPath.section == 0 && indexPath.row == 2){
        
        QuotesController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"thirdController"];
        navigationController.viewControllers = @[homeViewController];
      
       //XHNavigationController *navigationController = [[XHNavigationController alloc] initWithRootViewController:[[XHWaterfallViewController alloc] init]];
   

    }
 else if(indexPath.section == 1 && indexPath.row == 0){
        AuthorsController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"secondController"];
        navigationController.viewControllers = @[secondViewController];
    }
 else if(indexPath.section == 1 && indexPath.row == 1){
     FavorisViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FavorisController"];
     navigationController.viewControllers = @[secondViewController];
 }
    
    else if(indexPath.section == 1 && indexPath.row == 2){
        [PFUser logOut];
        [self logOutUser];
    }
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    
}


-(void)logOutUser{
    
    
    NSString *story;
    
    NSUserDefaults *storyB = [ NSUserDefaults standardUserDefaults];
    story =[storyB objectForKey:@"st"] ;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:story bundle:nil];
     LoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"loginView"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"Home", @"Random Quotes",@"Quotes"];
        cell.textLabel.text = titles[indexPath.row];
    } else {
        NSArray *titles = @[@"Authors", @"Favoris",@"Logout"];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    return cell;
}

- (void)_loadData {
    
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
          /*
            NSString *location = userData[@"location"][@"name"];
            NSString *gender = userData[@"gender"];
            NSString *birthday = userData[@"birthday"];
            NSString *relationship = userData[@"relationship_status"];
            */
        
            _label.text=name;
            [_label sizeToFit];
            _label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
            
            // Run network request asynchronously
            [NSURLConnection sendAsynchronousRequest:urlRequest
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:
             ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                 if (connectionError == nil && data != nil) {
                     _imageView.image=[UIImage imageWithData:data];
                 }
             }];
           
        }
        else if ([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
            NSString *twitterScreenName = [PFTwitterUtils twitter].screenName;
            _label.text=twitterScreenName;
            [_label sizeToFit];

            NSLog(@"twitter username %@",twitterScreenName);

            [PFTwitterUtils linkUser:[PFUser currentUser] block:^(BOOL succeeded, NSError *error) {
                
                if ([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]])
                {
                  

                   /*
                    NSString *twitterName;
                   
                    NSURL *verify = [NSURL URLWithString:@"https://api.twitter.com/1.1/account/verify_credentials.json"];
                    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:verify];
                   [[PFTwitterUtils twitter] signRequest:request];

                    NSURLResponse *response = nil;
                    NSError *error = nil;
                    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                         returningResponse:&response
                                                                     error:&error];
                        if(error==nil)
                        {
                            NSDictionary *JSON = [NSJSONSerialization
                                                  JSONObjectWithData: data
                                                  options: NSJSONReadingMutableContainers
                                                  error: &error];
                            twitterName = [JSON objectForKey:@""];

                        }
                    
                    
                  //  NSString *twitterScreenName = [PFTwitterUtils twitter].screenName;
                    //NSString *twitterProfilepic = [PFTwitterUtils twitter].
               

                */
                    }
                
            }];
                    
        }
        else if([PFUser currentUser]!=nil)
        {
            PFQuery *query= [PFUser query];
            
            [query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
            
            [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
                
              //  BOOL isPrivate = [[object objectForKey:@"isPrivate"]boolValue];
                _label.text=object[@"firstName"];
                [_label sizeToFit];
            }];
        }
    }];
}


@end
