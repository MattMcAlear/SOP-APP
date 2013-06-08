//
//  AllDetailViewControllers.h
//  SOP
//
//  Created by Matt McAlear on 4/1/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllDetailViewControllers : UIViewController

@property (strong, nonatomic) NSMutableArray *sopDescs; //Multidimensional array
@property (strong, nonatomic) NSMutableArray *sopDescTemp; //Multidimensional array
@property (strong, nonatomic) NSMutableArray *sopImages; //Multidimensional array
@property (strong, nonatomic) NSMutableArray *sop_id;
@property (strong, nonatomic) NSMutableArray *numOfSteps;
@property (strong, nonatomic) NSMutableArray *stepDidUpdate;
@property (strong, nonatomic) NSMutableArray *stepNumUpdate;
@property (strong, nonatomic) NSMutableArray *wentBackFromStep;
@property (strong, nonatomic) NSMutableArray *cameFromMaster;
@property (strong, nonatomic) NSMutableArray *cameFromMasterNum;

@end
