//
//  AppDelegate.h
//  SOP
//
//  Created by Matt McAlear on 2/22/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import <UIKit/UIKit.h>
//We get the other VC so we can save their state without having to reload
#import "CreateSopViewController2.h"
#import "DetailViewController.h"
#import "StepViewController.h"
#import "customCell.h"
#import "AllDetailViewControllers.h"
#import "sopDoc.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    CreateSopViewController2 *myVc1;
    DetailViewController *myVc2;
    StepViewController *myVc3;
    customCell *myVc4;
    AllDetailViewControllers *myVc5;
    sopDoc *myVc6;
}

@property (nonatomic, retain) IBOutlet CreateSopViewController2 *myVc1;
@property (nonatomic, retain) IBOutlet DetailViewController *myVc2;
@property (nonatomic, retain) IBOutlet StepViewController *myVc3;
@property (nonatomic, retain) IBOutlet customCell *myVc4;
@property (nonatomic, retain) IBOutlet AllDetailViewControllers *myVc5;
@property (nonatomic, retain) IBOutlet sopDoc *myVc6;
@property (nonatomic, copy) NSMutableArray *dvc;
@property (strong, nonatomic) UIWindow *window;

@end
