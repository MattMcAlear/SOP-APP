//
//  DetailViewController.h
//  SOP
//
//  Created by Matt McAlear on 2/22/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPostURL @"http://maggie.sscorp.com/sopData.php"
#define kSecret @"secret"
#define kSecretPass @"thisisasecretcode"

@interface DetailViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *stepLoading;
@property (strong, nonatomic) NSMutableArray *sopDescs;
@property (strong, nonatomic) NSMutableArray *sopDescTemp;
@property (strong, nonatomic) NSMutableArray *sopImages;
@property (nonatomic) int sop_id;
@property (nonatomic) int numOfSteps;
@property (nonatomic) int stepDidUpdate;
@property (nonatomic) int stepNumUpdate;
@property (nonatomic) int wentBackFromStep;
@property (nonatomic) int cameFromMaster;
@property (nonatomic) int cameFromMasterNum;

- (UIImage *) getSopId:(int)sopId getStepNum:(int)stepNum;
- (void)stepLoadingView;
- (void)stepLoadingSyc;

@end
