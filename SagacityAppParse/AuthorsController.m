//
//  AuthorsController.m
//  SagacityApp
//
//  Created by Nessrine Ben Amor on 11/23/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "AuthorsController.h"
#import "QuoteByAuthorControllerViewController.h"
#import "QueryClass.h"

@interface AuthorsController ()

@end

@implementation AuthorsController


-(void)moodChoice{
    NSInteger id=0;
    NSUserDefaults *mood = [ NSUserDefaults standardUserDefaults];
    id =[[mood objectForKey:@"md"] intValue];
    
    
    
    switch (id) {
        case 100:
        {
            //   _mood = @"angry";
            self.back.image = [UIImage imageNamed:@"07.jpg"];
            
        }
            break;
        case 101:
        {
            //   _mood = @"confused";
            self.back.image = [UIImage imageNamed:@"01.jpg"];
            
            
            
        }
            break;
        case 102:
        {
            // _mood = @"happy";
            self.back.image = [UIImage imageNamed:@"02.jpg"];
            
            
            
        }
            break;
        case 103:
        {
            // _mood = @"inlove";
            self.back.image = [UIImage imageNamed:@"02.jpg"];
            
            
            
        }
            break;
        case 104:
        {
            //   _mood = @"wondering";
            self.back.image = [UIImage imageNamed:@"03.jpg"];
            
            
            
        }
            break;
        case 105:
        {
            //  _mood = @"sleepy";
            self.back.image = [UIImage imageNamed:@"02.jpg"];
            
            
        }
            break;
        case 106:
        {
            //    _mood = @"sad";
            
            self.back.image = [UIImage imageNamed:@"04.jpg"];
            
            
            
        }
            break;
            
        default:
        {  // _mood = @"neutral";
            self.back.image = [UIImage imageNamed:@"02.jpg"];
        }
            
            
            break;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    [_authorsCollection setDataSource:self];
    [_authorsCollection setDelegate:self];
   
    [QueryClass getAuthor:^(NSArray *results) {
        imagesFilesArray = results;
        [_authorsCollection reloadData];
    }];
    
    [self moodChoice];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)showMenu:(id)sender {
    
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];}



#pragma mark - UICollection DaraSource

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
   
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [imagesFilesArray count];

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *cellIdentifier=@"imageCell";
    AuthorCell * cell=(AuthorCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    PFObject *imageObject= [imagesFilesArray objectAtIndex:indexPath.row];
    
    PFFile * imageFile=[imageObject objectForKey:@"image"];

    cell.loading.hidden=NO;
    
    [cell.loading startAnimating];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * data, NSError * error) {
        if (!error) {
            cell.authorImage.image = [UIImage imageWithData:data];
            [cell.loading stopAnimating];
            cell.loading.hidden=YES;


        }
    }];
    NSString *contentquote=[imageObject objectForKey:@"Name"];

    cell.nameAuthor.text=contentquote;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
     QuoteByAuthorControllerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"quoteByAuthor"];
    
    
    PFObject *imageObject= [imagesFilesArray objectAtIndex:indexPath.row];
    
    NSString *idAuthor= [imageObject valueForKey:@"objectId"];
    
    
/*
    
     PFImageView *creature = [[PFImageView alloc] init];
    creature.image = [UIImage imageNamed:@"load"]; // placeholder image
    creature.file = (PFFile *)imageFile;
    [creature loadInBackground];
  */
    vc.idAuthor=idAuthor;

    NSLog(@"************** this is your fucking id %@",idAuthor);
   // vc.authorImg= creature.image;

    

    
    [self.navigationController pushViewController:vc animated:YES];

}


@end
