//
//  QuoteByAuthorControllerViewController.m
//  SagacityAppParse
//
//  Created by ESPRIT on 14/12/2015.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "QuoteByAuthorControllerViewController.h"
#import "REFrostedViewController.h"
#import <Parse/Parse.h>
#import "QuoteCell.h"
#import "ShowImageCell.h"
#import "QuoteDetailViewController.h"

@interface QuoteByAuthorControllerViewController ()

@end

@implementation QuoteByAuthorControllerViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    // Do any additional setup after loading the view.
    [_quotesCollections setDataSource:self];
    [_quotesCollections setDelegate:self];
    // Do any additional setup after loading the view.
   // _authorImage.image=_authorImg;
  [self queryParseMethod];


}


-(void) viewDidAppear:(BOOL)animated{
    //NSLog(@"this is the id that your are goind to retreive data with%@",_idAuthor);
//    _authorImage.image=_authorImg;


}
-(void)queryParseMethod{
  
   // NSLog(@"******** Test number 2 Author id %@",_idAuthor);
    PFQuery *query=[PFQuery queryWithClassName:@"Quotes"];
    [query whereKey:@"idAuthor" equalTo:[PFObject objectWithoutDataWithClassName:@"Authors" objectId:_idAuthor]];
    [query selectKeys:@[@"image",@"content"]];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *  objects, NSError *  error)
     {
         if(!error) {
             imagesFilesArray= [[NSArray alloc] initWithArray:objects];
             [_quotesCollections reloadData];
         }
     }];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollection DaraSource

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [imagesFilesArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
static NSString *cellIdentifier=@"QuoteCell";
    
    QuoteCell * cell=(QuoteCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    PFObject *imageObject= [imagesFilesArray objectAtIndex:indexPath.row];
    
    PFFile * imageFile=[imageObject objectForKey:@"image"];

    cell.loading.hidden=YES;
    
  //  [cell.loading startAnimating];

    
     [imageFile getDataInBackgroundWithBlock:^(NSData * data, NSError * error) {
        if (!error) {
            cell.qImg.image = [UIImage imageWithData:data];
            [cell.loading stopAnimating];
            cell.loading.hidden=YES;

            
        }
    }];
    
    
    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    QuoteDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"quoteDetail"];
    
    
    //QuoteCell *cell = (QuoteCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"QuoteCell"forIndexPath:indexPath];
    
    
    PFObject *imageObject= [imagesFilesArray objectAtIndex:indexPath.row];
    NSString *contentquote=[imageObject objectForKey:@"content"];
    PFFile * imageFile=[imageObject objectForKey:@"image"];
    
    NSString *idQuote= [imageObject valueForKey:@"objectId"];
    
    /*
     
     PFImageView *creature = [[PFImageView alloc] init];
     creature.image = [UIImage imageNamed:@"load.gif"]; // placeholder image
     creature.file = (PFFile *)imageFile;
     [creature loadInBackground];
     
     vc.imgQuote= creature.image;
     */
    
    
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * data, NSError * error) {
        if (!error) {
            vc.imgQuote= [UIImage imageWithData:data];
        }
    }];
    
    //vc.imgTest= imageFile;
    
    
    
    NSString *content;
    content=contentquote;
    
    vc.titreString=contentquote;
    vc.idObj=idQuote;
    
    [self.navigationController pushViewController:vc animated:YES];}
@end
