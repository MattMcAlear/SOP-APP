//
//  sopDoc.h
//  SOP
//
//  Created by Matt McAlear on 4/14/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import <Foundation/Foundation.h>

@class sopData;

@interface sopDoc : NSObject

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

- (id)initWithID:(NSMutableArray*)sop_id numOfSteps:(NSMutableArray*)numOfSteps stepDidUpdate:(NSMutableArray*)stepDidUpdate stepNumUpdate:(NSMutableArray*)stepNumUpdate wentBackFromStep:(NSMutableArray*)wentBackFromStep cameFromMaster:(NSMutableArray*)cameFromMaster cameFromMasterNum:(NSMutableArray*)cameFromMasterNum sopDescs:(NSMutableArray*)sopDescs sopDescTemp:(NSMutableArray*)sopDescTemp sopImages:(NSMutableArray*)sopImages;

@end
