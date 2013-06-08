//
//  MasterViewController.h
//  SOP
//
//  Created by Matt McAlear on 2/22/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPostURL @"http://maggie.sscorp.com/sopData.php"
#define kSecret @"secret"
#define kSecretPass @"thisisasecretcode"

@interface MasterViewController : UITableViewController{
    NSURLConnection *postConnection;
    NSMutableArray *json;
}

@property (strong, nonatomic) NSMutableArray *json;
@property (strong, nonatomic) NSURLConnection *postConnection;
@property (strong, nonatomic) NSMutableArray *sops;
@property (strong, nonatomic) NSMutableArray *departments;
@property (nonatomic) int *numOfSections;
@property (nonatomic) int *sopLoadNum;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *sopLoading;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createSOP;


- (void) postMessage:(NSString *)message withName:(NSString *)name;
- (void)sopLoadingView;
- (void)sopLoadingSyc;
- (void)startGetSopData;
- (void) getSopData:(NSData *)data;
- (void)startDeleteSopData: (int)sop_id;
- (id)initWithTheme:(NSString *)theme;
+ (BOOL ) stringIsEmpty:(NSString *) aString;

@end
