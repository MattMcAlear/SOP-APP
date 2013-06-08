//
//  CreateSopViewController1.h
//  SOP
//
//  Created by Matt McAlear on 2/25/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateSopViewController1 : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate> {
    UIPickerView *pickerView;
    NSMutableArray *dataArray;
    int itemSelected;
}

@property (weak, nonatomic) IBOutlet UITextField *sopName;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic) int itemSelected;

- (IBAction)backgroundTouched:(id)sender;
- (NSString *) getDepartment;
- (NSString *) getSopName;

@end
