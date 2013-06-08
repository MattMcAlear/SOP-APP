//
//  CreateSopViewController2.h
//  SOP
//
//  Created by Matt McAlear on 2/25/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPostURL @"http://maggie.sscorp.com/sopData.php"
#define kSecret @"secret"
#define kSecretPass @"thisisasecretcode"

@interface CreateSopViewController2 : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>{
    
    NSURLConnection *postConnection;
    NSMutableArray *jsonImages;
    NSMutableArray *json;
}
@property (weak, nonatomic) IBOutlet UIImageView *sopImage;
@property (weak, nonatomic) IBOutlet UITextView *sopDescription;
@property (weak, nonatomic) IBOutlet UILabel *sopImageLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *stepLoader;
@property (weak, nonatomic) IBOutlet UILabel *stepLoaderLabel;
@property (strong, nonatomic) UIImagePickerController * picker;
@property (nonatomic) int saveNum;
@property (nonatomic) int uniqueID;
@property (nonatomic) int itemSelected;
@property (strong, nonatomic) NSString *sopName;
@property (strong, nonatomic) NSString *department;

- (IBAction)addPictureTapped:(id)sender;
- (IBAction)saveData:(id)sender;
- (IBAction)backgroundTouched:(id)sender;
- (IBAction)finishSaveData:(id)sender;
- (void) postMessage:(NSString *)sopImage withName:(NSString *)name withDepartment:(NSString *)department withDesc:(NSString *)desc withDeptID:(int)dept_id;
- (void) postMessage:(NSString *)sopImage withDesc:(NSString *)desc;
- (void) startSpinner;
- (void) startSync;

@end
