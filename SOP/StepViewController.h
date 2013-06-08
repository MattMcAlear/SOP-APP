//
//  StepViewController.h
//  SOP
//
//  Created by Matt McAlear on 2/23/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Base64.h"

#define kPostURL @"http://maggie.sscorp.com/sopData.php"
#define kSecret @"secret"
#define kSecretPass @"thisisasecretcode"

@interface StepViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>{
    NSURLConnection *postConnection;
    NSMutableArray *jsonImages;
    NSMutableArray *json;
}
    @property (weak, nonatomic) IBOutlet UIImageView *sopImage;
    @property (weak, nonatomic) IBOutlet UITextView *sopDescription;
    @property (strong, nonatomic) NSString *imageSent;
    @property (strong, nonatomic) NSString *descSent;
    @property (nonatomic) int sop_id;
    @property (nonatomic) int stepNum;
    @property (strong, nonatomic) UIImagePickerController * picker;
    @property (nonatomic) int didUpdate;

- (IBAction)changeSopImage:(id)sender;
- (void) postMessage:(NSString *)sopImage2;
- (void) postMessage2:(NSString *)sopDescription2;
- (void)executeSopImageChange;
- (void)executeSopDescriptionChange;

@end
