//
//  sopDoc.m
//  SOP
//
//  Created by Matt McAlear on 4/14/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import "sopDoc.h"

@implementation sopDoc

@synthesize sop_id = _sop_id;
@synthesize numOfSteps = _numOfSteps;
@synthesize stepDidUpdate = _stepDidUpdate;
@synthesize stepNumUpdate = _stepNumUpdate;
@synthesize wentBackFromStep = _wentBackFromStep;
@synthesize cameFromMaster = _cameFromMaster;
@synthesize cameFromMasterNum = _cameFromMasterNum;
@synthesize sopDescs = _sopDescs;
@synthesize sopDescTemp = _sopDescTemp;
@synthesize sopImages = _sopImages;


- (id)initWithID:(NSMutableArray*)sop_id numOfSteps:(NSMutableArray*)numOfSteps stepDidUpdate:(NSMutableArray*)stepDidUpdate stepNumUpdate:(NSMutableArray*)stepNumUpdate wentBackFromStep:(NSMutableArray*)wentBackFromStep cameFromMaster:(NSMutableArray*)cameFromMaster cameFromMasterNum:(NSMutableArray*)cameFromMasterNum sopDescs:(NSMutableArray*)sopDescs sopDescTemp:(NSMutableArray*)sopDescTemp sopImages:(NSMutableArray*)sopImages {
    if ((self = [super init])) {
        self.sop_id = sop_id;
        self.numOfSteps = numOfSteps;
        self.stepDidUpdate = stepDidUpdate;
        self.stepNumUpdate = stepNumUpdate;
        self.wentBackFromStep = wentBackFromStep;
        self.cameFromMaster = cameFromMaster;
        self.cameFromMasterNum = cameFromMasterNum;
        self.sopDescs = sopDescs;
        self.sopDescTemp = sopDescTemp;
        self.sopImages = sopImages;
    }
    return self;
}

@end
