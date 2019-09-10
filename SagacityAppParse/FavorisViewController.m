//
//  FavorisViewController.m
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 12/7/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "FavorisViewController.h"

@interface FavorisViewController ()

@end

@implementation FavorisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _tab.dataSource=self;
    _tab.delegate=self;
    _DB=[[DBManager alloc]initWithDatabaseFilename:@"sagacitydb1"];
    [self loaddata];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [self loaddata];
    [_tab reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    NSString * requete=@"select * from quote";
    _myarray=[[NSArray alloc]initWithArray:[_DB loadDataFromDB:requete]];
    
}

- (IBAction)showMenu:(id)sender {
    
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"myCell";
    
   // NSInteger indiceage=[_DB.arrColumnNames indexOfObject:@"id"];
    //NSString * age=[[_myarray objectAtIndex:indexPath.row]objectAtIndex:indiceage];
    
    //NSInteger indicenom=[_DB.arrColumnNames indexOfObject:@"author_name"];
    //NSString * nom=[[_myarray objectAtIndex:indexPath.row]objectAtIndex:indicenom];
    
    //NSInteger indiceprenom=[_DB.arrColumnNames indexOfObject:@"category_name"];
    //NSString * prenom=[[_myarray objectAtIndex:indexPath.row]objectAtIndex:indiceprenom];
    
    
    NSInteger indiceqte=[_DB.arrColumnNames indexOfObject:@"qte"];
    NSString * qte=[[_myarray objectAtIndex:indexPath.row]objectAtIndex:indiceqte];
    
   
    
    UITableViewCell* mycell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    
     UITextView *qt = (UITextView *)[tableView viewWithTag:1];
    
    qt.text = [NSString stringWithFormat:@"%@",qte];
    
    return  mycell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _myarray.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
