//
//  DetailViewController.m
//  SOP
//
//  Created by Matt McAlear on 2/22/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "customCell.h"
#import "StepViewController.h"
#import "sopData.h"
#import "AppDelegate.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

@synthesize sopImages;
@synthesize sopDescs;
@synthesize sopDescTemp;
@synthesize sop_id;
@synthesize stepLoading;
@synthesize numOfSteps;
@synthesize stepDidUpdate;
@synthesize stepNumUpdate;
@synthesize wentBackFromStep;
@synthesize cameFromMaster;
@synthesize cameFromMasterNum;

#pragma mark - Managing the detail item
/*
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}*/

- (void)configureView
{
    // Update the user interface for the detail item.
    
    //if (self.detailItem) {
    //    self.detailDescriptionLabel.text = [self.detailItem description];
    //}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[[self collectionView]setDataSource:self];
    [[self collectionView]setDelegate:self];
    
    //Need to alloc and init to store UIImage's in the array ;)
    self.sopImages = [[NSMutableArray alloc] init];
        
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"cameFromMaster = %d, cameFromMasterNum = %d, wentBackFromStep = %d, stepDidUpdate = %d", cameFromMaster, cameFromMasterNum, wentBackFromStep, stepDidUpdate);
    
    if (self.cameFromMaster == 1 && self.cameFromMasterNum > 1) {
        for (int i=0; i<sizeof(appDelegate.dvc); i++) {
            self.sop_id = appDelegate.dvc[i][0];
//            if (self.sop_id == (int)appDelegate.myVc5.sop_id[i]) {
//                self.sopImages = appDelegate.myVc5.sopImages[i];
//                self.sopDescs = appDelegate.myVc5.sopDescs[i];
//                self.sopDescTemp = appDelegate.myVc5.sopDescTemp[i];
//                //self.sop_id = appDelegate.myVc5.sop_id[i];
//                self.numOfSteps = (int)appDelegate.myVc5.numOfSteps[i];
//            }
        }
    }else if (self.wentBackFromStep == 1 && self.stepDidUpdate == 1){
        for (int i=0; i<sizeof(appDelegate.myVc5.sop_id); i++) {
            if (self.sop_id == (int)appDelegate.myVc5.sop_id[i]) {
                self.sopImages = appDelegate.myVc5.sopImages[i];
                self.sopDescs = appDelegate.myVc5.sopDescs[i];
                self.sopDescTemp = appDelegate.myVc5.sopDescTemp[i];
                //self.sop_id = appDelegate.myVc5.sop_id[i];
                self.numOfSteps = (int)appDelegate.myVc5.numOfSteps[i];
            }
        }
//    }else if (self.cameFromMaster == 1 && self.cameFromMaster == 1){
//        NSMutableArray *sopDescs2 = [[NSMutableArray alloc] init]; //Multidimensional array
//        NSMutableArray *sopDescTemp2 = [[NSMutableArray alloc] init]; //Multidimensional array
//        NSMutableArray *sopImages2 = [[NSMutableArray alloc] init]; //Multidimensional array
//        NSMutableArray *sop_id2 = [[NSMutableArray alloc] init];
//        NSMutableArray *numOfSteps2 = [[NSMutableArray alloc] init];
//        NSMutableArray *stepDidUpdate2 = [[NSMutableArray alloc] init];
//        NSMutableArray *stepNumUpdate2 = [[NSMutableArray alloc] init];
//        NSMutableArray *wentBackFromStep2 = [[NSMutableArray alloc] init];
//        NSMutableArray *cameFromMaster2 = [[NSMutableArray alloc] init];
//        NSMutableArray *cameFromMasterNum2 = [[NSMutableArray alloc] init];
//        
//        [sopDescs2 addObject:[NSMutableArray arrayWithObjects:self.sopDescTemp[0], self.sopDescTemp[1], self.sopDescTemp[2], self.sopDescTemp[3], self.sopDescTemp[4], self.sopDescTemp[5], self.sopDescTemp[6], self.sopDescTemp[7], nil]];
//        [sopDescTemp2 addObject:self.sopDescTemp];
//        [sopImages2 addObject:self.sopImages];
//        [sop_id2 addObject:[NSNumber numberWithInt:self.sop_id]];
//        [numOfSteps2 addObject:[NSNumber numberWithInt:self.numOfSteps]];
//        [stepDidUpdate2 addObject:[NSNumber numberWithInt:0]];
//        [stepNumUpdate2 addObject:[NSNumber numberWithInt:0]];
//        [wentBackFromStep2 addObject:[NSNumber numberWithInt:0]];
//        [cameFromMaster2 addObject:[NSNumber numberWithInt:self.cameFromMaster]];
//        [cameFromMasterNum2 addObject:[NSNumber numberWithInt:self.cameFromMasterNum]];
//        
//        //NSLog(@"sopDesc = %@, sopDescTemp = %@, sopImages = %@, sopID = %d, numOfSteps = %d, stepDidUpdate2")
//        
//        appDelegate.myVc5.sopDescs = sopDescs2;
//        appDelegate.myVc5.sopDescTemp = sopDescTemp2;
//        appDelegate.myVc5.sopImages = sopImages2;
//        appDelegate.myVc5.sop_id = sop_id2;
//        appDelegate.myVc5.numOfSteps = numOfSteps2;
//        appDelegate.myVc5.stepDidUpdate = stepDidUpdate2;
//        appDelegate.myVc5.stepNumUpdate = stepNumUpdate2;
//        appDelegate.myVc5.wentBackFromStep = wentBackFromStep2;
//        appDelegate.myVc5.cameFromMaster = cameFromMaster2;
//        appDelegate.myVc5.cameFromMasterNum = cameFromMasterNum2;
        
    }else{
        //No need - will do it when cells finish loading
        //appDelegate.myVc2 = self;
        
        //For testing and default
        self.sopDescs = [NSMutableArray arrayWithObjects:self.sopDescTemp[0], self.sopDescTemp[1], self.sopDescTemp[2], self.sopDescTemp[3], self.sopDescTemp[4], self.sopDescTemp[5], self.sopDescTemp[6], self.sopDescTemp[7], nil];
        
        [appDelegate.dvc addObject:self];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //Stop loader
    [stepLoading stopAnimating];
	[super viewWillDisappear:animated];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numOfSteps;
}

- (UIImage *) getSopId:(int)sopId getStepNum:(int)stepNum{
    NSString *urlString = [NSString stringWithFormat:@"http://portal.sscorp.com/sopData.php?secret=thisisasecretcode&message=getImageData&sop_id=%d&stepNum=%d", sopId, stepNum];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"step";
    customCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //[NSThread detachNewThreadSelector:@selector(getSopId:getStepNum:) toTarget:self withObject:nil];
    
    if(self.cameFromMasterNum <= 1){
        UIImage *image = [self getSopId:sop_id getStepNum:indexPath.item+1];
        [sopImages addObject:image];
        NSLog(@"%@", [sopImages objectAtIndex:indexPath.item]);
        
        [[cell sopImage]setImage:image];
        [[cell sopDesc]setText:[NSString stringWithFormat:@"Step %d", indexPath.item+1]];
    }else{        
        UIImage *image = [self.sopImages objectAtIndex:indexPath.item];
        NSLog(@"%@", [self.sopImages objectAtIndex:indexPath.item]);
        
        [[cell sopImage]setImage:image];
        [[cell sopDesc]setText:[NSString stringWithFormat:@"Step %d", indexPath.item+1]];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    for (int i=0; i<sizeof(appDelegate.myVc6.sopImages); i++) {
        if ((int)appDelegate.myVc5.sop_id[i] == self.sop_id) {
            
            NSMutableArray *sopDescs2 = [[NSMutableArray alloc] init]; //Multidimensional array
            NSMutableArray *sopDescTemp2 = [[NSMutableArray alloc] init]; //Multidimensional array
            NSMutableArray *sopImages2 = [[NSMutableArray alloc] init]; //Multidimensional array
            NSMutableArray *sop_id2 = [[NSMutableArray alloc] init];
            NSMutableArray *numOfSteps2 = [[NSMutableArray alloc] init];
            NSMutableArray *stepDidUpdate2 = [[NSMutableArray alloc] init];
            NSMutableArray *stepNumUpdate2 = [[NSMutableArray alloc] init];
            NSMutableArray *wentBackFromStep2 = [[NSMutableArray alloc] init];
            NSMutableArray *cameFromMaster2 = [[NSMutableArray alloc] init];
            NSMutableArray *cameFromMasterNum2 = [[NSMutableArray alloc] init];
            
            sopDescs2 = appDelegate.myVc6.sopDescs;
            sopDescTemp2 = appDelegate.myVc6.sopDescTemp;
            sopImages2 = appDelegate.myVc6.sopImages;
            sop_id2 = appDelegate.myVc6.sop_id;
            numOfSteps2 = appDelegate.myVc6.numOfSteps;
            stepDidUpdate2 = appDelegate.myVc6.stepDidUpdate;
            stepNumUpdate2 = appDelegate.myVc6.stepNumUpdate;
            wentBackFromStep2 = appDelegate.myVc6.wentBackFromStep;
            cameFromMaster2 = appDelegate.myVc6.cameFromMaster;
            cameFromMasterNum2 = appDelegate.myVc6.cameFromMasterNum;
            
            [sopDescs2 addObject:self.sopDescs];
            [sopDescTemp2 addObject:self.sopDescTemp];
            [sopImages2 addObject:self.sopImages];
            [sop_id2 addObject:[NSNumber numberWithInt:self.sop_id]];
            [numOfSteps2 addObject:[NSNumber numberWithInt:self.numOfSteps]];
            [stepDidUpdate2 addObject:[NSNumber numberWithInt:self.stepDidUpdate]];
            [stepNumUpdate2 addObject:[NSNumber numberWithInt:self.stepNumUpdate]];
            [wentBackFromStep2 addObject:[NSNumber numberWithInt:self.wentBackFromStep]];
            [cameFromMaster2 addObject:[NSNumber numberWithInt:self.cameFromMaster]];
            [cameFromMasterNum2 addObject:[NSNumber numberWithInt:self.cameFromMasterNum]];
            
            //[appDelegate.myVc6 initWithID:sop_id2 numOfSteps:numOfSteps2 stepDidUpdate:stepDidUpdate2 stepNumUpdate:stepNumUpdate2 wentBackFromStep:wentBackFromStep2 cameFromMaster:cameFromMaster2 cameFromMasterNum:cameFromMasterNum2 sopDescs:sopDescs2 sopDescTemp:sopDescTemp2 sopImages:sopImages2];
            
            appDelegate.myVc5.sopDescs = sopDescs2;
            appDelegate.myVc5.sopDescTemp = sopDescTemp2;
            appDelegate.myVc5.sopImages = sopImages2;
            appDelegate.myVc5.sop_id = sop_id2;
            appDelegate.myVc5.numOfSteps = numOfSteps2;
            appDelegate.myVc5.stepDidUpdate = stepDidUpdate2;
            appDelegate.myVc5.stepNumUpdate = stepNumUpdate2;
            appDelegate.myVc5.wentBackFromStep = wentBackFromStep2;
            appDelegate.myVc5.cameFromMaster = cameFromMaster2;
            appDelegate.myVc5.cameFromMasterNum = cameFromMasterNum2;
            
            break;
        }
    }
        
    //appDelegate.myVc2 = self;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //[self performSegueWithIdentifier:@"goToStep" sender:self];
}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
/*
- (NSIndexPath *)collectionView:(UICollectionView *)collectionView willSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedStep = indexPath.item;
    
    NSLog(@"This is %d", [self.sopDescs count]);
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)stepLoadingView {
    [stepLoading startAnimating];
}

- (void)stepLoadingSyc {
    [NSThread detachNewThreadSelector:@selector(stepLoadingView) toTarget:self withObject:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToStep"])
    {
        //Start step loading indicator
        [self stepLoadingSyc];
        
        StepViewController *stepController = segue.destinationViewController;
        
        customCell *cell = (customCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        int num = indexPath.item;
                        
        NSString *step = [NSString stringWithFormat:@"Step %d", num+1];
        stepController.title = step;
        stepController.descSent = [self.sopDescs objectAtIndex:num];
        stepController.sop_id = self.sop_id;
        stepController.stepNum = num+1;
        
        //Stop step loading indicator
        [stepLoading stopAnimating];
    }
}

@end
