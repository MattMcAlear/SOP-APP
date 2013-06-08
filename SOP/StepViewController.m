//
//  StepViewController.m
//  SOP
//
//  Created by Matt McAlear on 2/23/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import "StepViewController.h"
#import "DetailViewController.h"

@interface StepViewController ()

@end

@implementation StepViewController

@synthesize sopDescription;
@synthesize sopImage;
@synthesize imageSent;
@synthesize descSent;
@synthesize sop_id;
@synthesize stepNum;
@synthesize picker = _picker;
@synthesize didUpdate;

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
    
    self.sopDescription.delegate = self;
    
    NSString *urlString = [NSString stringWithFormat:@"http://portal.sscorp.com/sopData.php?secret=thisisasecretcode&message=getImageData&sop_id=%d&stepNum=%d", sop_id, stepNum];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.sopImage.image = image;
    self.sopDescription.text = descSent;
    self.didUpdate = 0;
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

-(void)textViewDidEndEditing:(UITextView *)textView{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        
        [self executeSopDescriptionChange];
        
    }];
    //[self performSelectorOnMainThread:@selector(executeSopDescriptionChange) withObject:nil waitUntilDone:YES];
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
    
    [NSThread detachNewThreadSelector:@selector(executeSopImageChange) toTarget:self withObject:nil];
    //[self executeSopImageChange];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeSopImage:(id)sender {
    if (self.picker == nil) {
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //self.picker.sourceType = UIImagePickerControllerCameraCaptureModePhoto;
        self.picker.allowsEditing = NO;
    }
    [self.navigationController presentViewController:_picker animated:YES completion:nil];
}

- (void) postMessage:(NSString *)sopImage2{
    NSMutableString *post = [NSMutableString stringWithFormat:@"%@=%@", kSecret, kSecretPass];
    [post appendString:[NSString stringWithFormat:@"&message=updateImageData"]];
    [post appendString:[NSString stringWithFormat:@"&count=%d", stepNum]];
    [post appendString:[NSString stringWithFormat:@"&imageData=%@", sopImage2]];
    [post appendString:[NSString stringWithFormat:@"&id=%d", sop_id]];
    
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
        //Awesome!
    }else{
        //Dang it
    }
}

- (void) postMessage2:(NSString *)sopDescription2{
    NSMutableString *post = [NSMutableString stringWithFormat:@"%@=%@", kSecret, kSecretPass];
    [post appendString:[NSString stringWithFormat:@"&message=updateDescription"]];
    [post appendString:[NSString stringWithFormat:@"&count=%d", stepNum]];
    [post appendString:[NSString stringWithFormat:@"&description=%@", sopDescription2]];
    [post appendString:[NSString stringWithFormat:@"&id=%d", sop_id]];
    
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
        //Awesome!
    }else{
        //Dang it
    }
}

- (void)executeSopImageChange{
    //Get image data
    NSData *data = UIImageJPEGRepresentation (sopImage.image, .5);
    
    //Convert data to hexadecimal (long processing time)
    NSString *imageData2 = [data hexadecimalString];
    
    [self postMessage:imageData2];
    
    self.didUpdate = 1;
}

- (void)executeSopDescriptionChange{
    //Get sop text
    NSString *description = sopDescription.text;
    
    [self postMessage2:description];
    
    self.didUpdate = 1;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToStep"])
    {
        
        DetailViewController *detailController = segue.destinationViewController;
        
        detailController.stepDidUpdate = self.didUpdate;
        detailController.wentBackFromStep = 1;
        
    }
}


@end
