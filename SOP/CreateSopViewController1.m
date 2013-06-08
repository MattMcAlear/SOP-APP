//
//  CreateSopViewController1.m
//  SOP
//
//  Created by Matt McAlear on 2/25/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import "CreateSopViewController1.h"
#import "CreateSopViewController2.h"

@interface CreateSopViewController1 ()

@end

@implementation CreateSopViewController1

@synthesize pickerView;
@synthesize dataArray;
@synthesize itemSelected;
@synthesize sopName;

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
    
    sopName.delegate = self;
	
    dataArray = [[NSMutableArray alloc] init];
    
    [dataArray addObject:@"Warehouse"];
    [dataArray addObject:@"MUPS"];
    [dataArray addObject:@"Wire Loading"];
    [dataArray addObject:@"New Ops"];
    [dataArray addObject:@"Truck Processing"];
    [dataArray addObject:@"Drain"];
    [dataArray addObject:@"Small Autos"];
    [dataArray addObject:@"Big Autos"];
    [dataArray addObject:@"Mandrels"];
    [dataArray addObject:@"Shipping"];
    [dataArray addObject:@"Receiving"];
    [dataArray addObject:@"Extension Cell"];
    
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    float pickerWidth = screenWidth;// * .75;
    float pickerHeight = 216;
    
    float xPoint = screenWidth / 2 - (pickerWidth / 2);
    float yPoint = screenHeight / 2 - (pickerHeight / 2);
    
    pickerView = [[UIPickerView alloc] init];
    
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    
    [pickerView setFrame: CGRectMake(xPoint, yPoint, pickerWidth, pickerHeight)];
    
    pickerView.showsSelectionIndicator = YES;
    
    [pickerView selectRow:0 inComponent:0 animated:YES];
    
    [self.view addSubview:pickerView];
}

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [dataArray objectAtIndex: row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.itemSelected = *(&(row));
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    // Get the text of the row.
    NSString *rowItem = [dataArray objectAtIndex: row];
    
    // Create and init a new UILabel.
    // We must set our label's width equal to our picker's width.
    // We'll give the default height in each row.
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    
    // Center the text.
    [lblRow setTextAlignment:UITextAlignmentCenter];
    
    // Make the text color red.
    //[lblRow setTextColor: [UIColor redColor]];
    
    // Add the text.
    [lblRow setText:rowItem];
    
    // Clear the background color to avoid problems with the display.
    [lblRow setBackgroundColor:[UIColor clearColor]];
    
    // Return the label.
    return lblRow;
}

- (IBAction)backgroundTouched:(id)sender{
    [sopName resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (NSString *) getDepartment{
    return [self.dataArray objectAtIndex:(NSUInteger)self.itemSelected];
}

- (NSString *) getSopName{
    return self.sopName.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)senderd
{
    if ([[segue identifier] isEqualToString:@"createSop2"]) {
        CreateSopViewController2 *cvc2 =segue.destinationViewController;
                
        cvc2.sopName = self.sopName.text;
        cvc2.department = [self.dataArray objectAtIndex:itemSelected];
        cvc2.itemSelected = itemSelected;
    }
    
    if ([[segue identifier] isEqualToString:@"createSop1"]) {
        //Nothing
    }
}

@end
