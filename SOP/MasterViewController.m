//
//  MasterViewController.m
//  SOP
//
//  Created by Matt McAlear on 2/22/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "sopData.h"
#import "AppDelegate.h"
#import "ThemeManager.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

@synthesize sops;
@synthesize departments;
@synthesize numOfSections;
@synthesize sopLoadNum;
@synthesize sopLoading;
@synthesize json;
@synthesize postConnection;
@synthesize createSOP;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startGetSopData];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
//    [button addTarget:self action:@selector(showNewDetail:)forControlEvents:UIControlEventTouchUpInside];

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;    
}

- (void) getSopData:(NSData *)data{
    NSError *error;
    
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    [self.tableView reloadData];
}

- (void)startGetSopData{
    NSMutableString *postString = [NSMutableString stringWithString:kPostURL];
    
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", kSecret, kSecretPass]];
    [postString appendString:[NSString stringWithFormat:@"&message=getData"]];
    
    NSURL *url = [NSURL URLWithString:postString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    [self getSopData:data];
}

- (void)startDeleteSopData: (int)sop_id{
    NSMutableString *postString = [NSMutableString stringWithString:kPostURL];
    
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", kSecret, kSecretPass]];
    [postString appendString:[NSString stringWithFormat:@"&message=deleteData"]];
    [postString appendString:[NSString stringWithFormat:@"&sop_id=%d", sop_id]];
    
    NSURL *url = [NSURL URLWithString:postString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    
    NSMutableDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
    NSString *result = [jsonData objectForKey:@"result"];
    
    if([result isEqual: @"success"]){
        //awesome
    }else{
        //dang it!
    }
}

- (void)sopLoadingView {
    [sopLoading startAnimating];
}

- (void)sopLoadingSyc {
    [NSThread detachNewThreadSelector:@selector(sopLoadingView) toTarget:self withObject:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self startGetSopData];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    //Stop loader
    [sopLoading stopAnimating];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //Stop loader
    [sopLoading stopAnimating];
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    departments = [[NSMutableArray alloc]init];
    BOOL deptMatch = FALSE;
    for(int i=0; i<[json count]; i++){
        deptMatch = FALSE;
        NSDictionary *deptIndex = [json objectAtIndex:i];
        
        if([departments count] == 0){
            [departments addObject:[deptIndex objectForKey:@"department"]];
        }else{
            for(int ii=0; ii<[departments count]; ii++){
                if ([deptIndex objectForKey:@"department"] == departments[ii]) {
                    deptMatch = TRUE;
                }
            }
            
            if(deptMatch == FALSE){
                [departments addObject:[deptIndex objectForKey:@"department"]];
                //dept = [NSMutableArray arrayWithObject:[deptIndex objectForKey:@"department"]];
            }
        }
    }
    
    return [departments count];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    for (int i=0; i<[departments count]; i++) {
        if (section == i) {
            return [departments objectAtIndex:i];
        }
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    
    for (int i=0; i<[json count]; i++) {
        NSDictionary *depts = [json objectAtIndex:i];
        int dept_id = [[depts objectForKey:@"department_id"] intValue]-1;
        
        if(section == dept_id){
            count++;
        }
    }
    
    return count;
    //return [json count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allSops"];
    
    int count = 0;
    
    for (int i=0; i<[json count]; i++) {
        NSDictionary *info2 = [json objectAtIndex:i];
        int dept_id = [[info2 objectForKey:@"department_id"] intValue]-1;
        int index_id = [[info2 objectForKey:@"index_id"] intValue];

        if(indexPath.section == dept_id && indexPath.row == index_id){
            count = i;
            break;
        }else if(indexPath.section == dept_id && indexPath.row == 0){
            count = i;
            break;
        }
    }

    NSDictionary *info = [json objectAtIndex:count];
    cell.textLabel.text = [info objectForKey:@"name"];
    
    return cell;
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int count = 0;
    
    for (int i=0; i<[json count]; i++) {
        NSDictionary *info2 = [json objectAtIndex:i];
        int dept_id = [[info2 objectForKey:@"department_id"] intValue]-1;
        int index_id = [[info2 objectForKey:@"index_id"] intValue];
        
        if(indexPath.section == dept_id && indexPath.row == index_id){
            count = i;
            break;
        }else if(indexPath.section == dept_id && indexPath.row == 0){
            count = i;
            break;
        }
    }
    
    NSDictionary *info = [json objectAtIndex:count];
    int sop_id = [[info objectForKey:@"id"] integerValue];
        
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:json];
        [newArray removeObjectAtIndex:count];
        json = newArray;
        [_objects removeObjectAtIndex:count];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self startDeleteSopData:sop_id];
        
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

+ (BOOL) stringIsEmpty:(NSString *) aString {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"viewSop"]) {
        //Start loading indicator
        [self sopLoadingSyc];
        
        DetailViewController *detailController =segue.destinationViewController;
        
        int count = 0;
        
        for (int i=0; i<[json count]; i++) {
            NSDictionary *info2 = [json objectAtIndex:i];
            int dept_id = [[info2 objectForKey:@"department_id"] intValue]-1;
            int index_id = [[info2 objectForKey:@"index_id"] intValue];
            
            if(self.tableView.indexPathForSelectedRow.section == dept_id && self.tableView.indexPathForSelectedRow.row == index_id){
                count = i;
                break;
            }else if(self.tableView.indexPathForSelectedRow.section == dept_id && self.tableView.indexPathForSelectedRow.row == 0){
                count = i;
                break;
            }
        }
        
        //NSString *sop = [self.sops objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        NSDictionary *info = [json objectAtIndex:count];

        NSMutableArray *steps = [NSMutableArray arrayWithObjects:[info objectForKey:@"step1"], [info objectForKey:@"step2"], [info objectForKey:@"step3"], [info objectForKey:@"step4"], [info objectForKey:@"step5"], [info objectForKey:@"step6"], [info objectForKey:@"step7"], [info objectForKey:@"step8"], nil];
        
        int numOfSteps = 0;
        for (int i=1; i<20; i++) {
            if ([[info objectForKey:[NSString stringWithFormat:@"step%d", i]] isEqual:[NSNull null]]) {
                numOfSteps = i-1;
                break;
            }else if([[info objectForKey:[NSString stringWithFormat:@"step%d", i]] length] == 0){
                numOfSteps = i-1;
                break;
            }else{
                
            }
        }
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        detailController.title = [info objectForKey:@"name"];
        detailController.sopDescTemp = steps;
        detailController.sop_id = [[info objectForKey:@"id"] integerValue];
        detailController.numOfSteps = numOfSteps;
        detailController.cameFromMaster = 1;
        detailController.cameFromMasterNum = appDelegate.myVc2.cameFromMasterNum + 1;
        
        //Stop loader
        [sopLoading stopAnimating];
    }
    
    if ([[segue identifier] isEqualToString:@"createSop1"]) {
        //Nothing
    }
}

@end
