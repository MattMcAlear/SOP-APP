//
//  AllDetailViewControllers.m
//  SOP
//
//  Created by Matt McAlear on 4/1/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import "AllDetailViewControllers.h"

@interface AllDetailViewControllers ()

@end

@implementation AllDetailViewControllers

@synthesize sopImages;
@synthesize sopDescs;
@synthesize sopDescTemp;
@synthesize sop_id;
@synthesize numOfSteps;
@synthesize stepDidUpdate;
@synthesize stepNumUpdate;
@synthesize wentBackFromStep;
@synthesize cameFromMaster;
@synthesize cameFromMasterNum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
