//
//  CreateSopViewController2.m
//  SOP
//
//  Created by Matt McAlear on 2/25/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import "CreateSopViewController2.h"
#import "CreateSopViewController1.h"
#import "Base64.h"
#import <QuartzCore/QuartzCore.h> // for the UIImageView
#import "AppDelegate.h"

@interface CreateSopViewController2 ()

@end

@implementation CreateSopViewController2

@synthesize sopDescription = _sopDescription;
@synthesize sopImage = _sopImage;
@synthesize sopImageLabel = _sopImageLabel;
@synthesize picker = _picker;
@synthesize saveNum = _saveNum;
@synthesize uniqueID = _uniqueID;
@synthesize itemSelected = _itemSelected;
@synthesize sopName = _sopName;
@synthesize department = _department;
@synthesize stepLoader = _stepLoader;
@synthesize stepLoaderLabel = _stepLoaderLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sopDescription.delegate = self;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.myVc1.saveNum != 0 && appDelegate.myVc1.saveNum > 0) {
        _sopDescription.text = appDelegate.myVc1.sopDescription.text;
        _sopImage.image = appDelegate.myVc1.sopImage.image;
        _sopImageLabel.text = appDelegate.myVc1.sopImageLabel.text;
        _saveNum = appDelegate.myVc1.saveNum;
        _uniqueID = appDelegate.myVc1.uniqueID;
        _itemSelected = appDelegate.myVc1.itemSelected;
        _sopName = appDelegate.myVc1.sopName;
        _department = appDelegate.myVc1.department;
        _stepLoaderLabel.text = @"";
        self.title = [NSString stringWithFormat:@"Step %d", _saveNum+1];
    }else{
        //The step number
        _saveNum = 0;
    
        //The loading text
        _stepLoaderLabel.text = @"";
    }
    
    [_sopImage.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_sopImage.layer setBorderWidth: 1.0];
}

- (void) postMessage:(NSString *)sopImage withName:(NSString *)name withDepartment:(NSString *)department withDesc:(NSString *)desc withDeptID:(int)dept_id{
    
    NSMutableString *post = [NSMutableString stringWithFormat:@"%@=%@", kSecret, kSecretPass];
    [post appendString:[NSString stringWithFormat:@"&message=saveData"]];
    [post appendString:[NSString stringWithFormat:@"&count=%d", _saveNum]];
    [post appendString:[NSString stringWithFormat:@"&name=%@", name]];
    [post appendString:[NSString stringWithFormat:@"&department=%@", department]];
    [post appendString:[NSString stringWithFormat:@"&department_id=%d", dept_id+1]];
    [post appendString:[NSString stringWithFormat:@"&imageData=%@", sopImage]];
    [post appendString:[NSString stringWithFormat:@"&description=%@", desc]];
    
    //NSLog(@"%@", post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:kPostURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
    NSData *data2 = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSMutableDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:&error];
    
    NSLog(@"%@", jsonData);
    
    //NSDictionary *info = [jsonData objectAtIndex:0];
    NSString *result = [jsonData objectForKey:@"result"];

    if([result isEqual: @"success"]){
        _saveNum++;
        _uniqueID = [[jsonData objectForKey:@"id"] integerValue];
        
        self.title = [NSString stringWithFormat:@"Step %d", _saveNum+1];
    }else{
        self.title = @"Failed to save step 1!";
    }
}

- (void) postMessage:(NSString *)sopImage withDesc:(NSString *)desc{
    
    NSMutableString *post = [NSMutableString stringWithFormat:@"%@=%@", kSecret, kSecretPass];
    [post appendString:[NSString stringWithFormat:@"&message=saveData"]];
    [post appendString:[NSString stringWithFormat:@"&count=%d", _saveNum]];
    [post appendString:[NSString stringWithFormat:@"&imageData=%@", sopImage]];
    [post appendString:[NSString stringWithFormat:@"&description=%@", desc]];
    [post appendString:[NSString stringWithFormat:@"&id=%d", _uniqueID]];
        
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:kPostURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
    NSData *data2 = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSMutableDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:&error];
    
    NSLog(@"%@", jsonData);
    
    NSString *result = [jsonData objectForKey:@"result"];
    
    if([result isEqual: @"success"]){
        _saveNum++;
        
        self.title = [NSString stringWithFormat:@"Step %d", _saveNum+1];
    }else{
        self.title = [NSString stringWithFormat:@"Failed to save step %d!", _saveNum+1];
    }
}

- (IBAction)addPictureTapped:(id)sender {
    if (self.picker == nil) {
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.allowsEditing = NO;
    }
    [self.navigationController presentViewController:_picker animated:YES completion:nil];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.myVc1 = self;
}

- (IBAction)saveData:(id)sender {
    //The step loader
    [self startASyncLoader];
    
    //Get image data
    NSData *data = UIImageJPEGRepresentation (_sopImage.image, .5);
    //NSData *data2 = UIImagePNGRepresentation(_sopImage.image);
    //NSString *imageData = [data base64Encoding];
    
    //Convert data to hexadecimal (long processing time)
    NSString *imageData2 = [data hexadecimalString];
    
    if (_saveNum == 0) {
        [self postMessage:imageData2 withName:self.sopName withDepartment:self.department withDesc:_sopDescription.text withDeptID:_itemSelected];
    }else if (_saveNum > 0){
        [self postMessage:imageData2 withDesc:_sopDescription.text];
    }else{
        //Can't compute
    }
    
    [_stepLoader stopAnimating];
    self.stepLoaderLabel.text = @"";
}

- (IBAction)backgroundTouched:(id)sender {
    [_sopDescription resignFirstResponder];
}

- (IBAction)finishSaveData:(id)sender {
    if (_saveNum > 0) {
        //reset vars to beginning
        _sopDescription.text = @"";
        _sopImage.image = nil;
        _sopImageLabel.text = @"";
        _saveNum = 0;
        self.title = [NSString stringWithFormat:@"Step %d", _saveNum+1];
        self.sopImageLabel.text = @"Add Image";
    }else{
        //Can't compute
    }
}

- (void) startSpinner {
    [_stepLoader startAnimating];
    
    self.stepLoaderLabel.text = @"Saving Data...";
}

- (void)startASyncLoader {
    [NSThread detachNewThreadSelector:@selector(startSpinner) toTarget:self withObject:nil];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    NSUInteger length = textView.text.length;
    [textView setSelectedRange:NSMakeRange(0, length)];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.myVc1 = self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }else{
        //NON
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    //UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
    self.sopImage.image = fullImage;
    self.sopImageLabel.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
