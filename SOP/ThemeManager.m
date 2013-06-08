//
//  ThemeManager.m
//  SOP
//
//  Created by Matt McAlear on 4/3/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

+ (void)applySixthNavigationAppearanceWithImage:(UIImage *)menuBarImage backButton:(UIImage *)backButtonImage {
//    
//    [[UINavigationBar appearance] setBackgroundImage:menuBarImage forBarMetrics:UIBarMetricsDefault];
//    
//    backButtonImage = [backButtonImage
//                       resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 5.0f)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
//                                                      forState:UIControlStateNormal
//                                                    barMetrics:UIBarMetricsDefault];
//    
//    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:-1.0f forBarMetrics:UIBarMetricsDefault];
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                          [UIColor whiteColor], UITextAttributeTextColor,
//                                                          [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:23.0f], UITextAttributeFont,
//                                                          nil]];
}

+ (void)applySixthGreenNavigationAppearance {
//    UIImage *menuBarImage = [UIImage imageNamed:@"6-green-navigation-bar.png"];
//    UIImage *backButtonImage = [UIImage imageNamed:@"6-green-back-button.png"];
//    
//    [self applySixthNavigationAppearanceWithImage:menuBarImage backButton:backButtonImage];
}

+ (void)applySixthThemeWithView:(UIView *)view navItem:(UINavigationItem *)navItem navBar:(UINavigationBar *)navBar backgroundImage:(UIImage *)backgroundImage settingsButtonImage:(UIImage *)settingsButtonImage bottomMenuImage:(UIImage *)bottomMenuImage leftArrow:(UIImage *)leftArrow rightArrow:(UIImage *)rightArrow {
    
    //navBar.translucent = YES;
    
    UIImageView *background = [[UIImageView alloc] initWithImage:backgroundImage];
    //[view addSubview:background];
    [view insertSubview:background atIndex:0];
    
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingsButton.frame = CGRectMake(0.0f, 0.0f, settingsButtonImage.size.width, settingsButtonImage.size.height);
    [settingsButton setImage:settingsButtonImage forState:UIControlStateNormal];
    [settingsButton addTarget:view.window.rootViewController action:@selector(dismissController) forControlEvents:UIControlEventTouchUpInside];
    
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    
    UIImageView *bottomView = [[UIImageView alloc] initWithImage:bottomMenuImage];
    bottomView.frame = CGRectMake(0.0f, view.frame.size.height - bottomView.frame.size.height, bottomView.frame.size.width, bottomView.frame.size.height);
    bottomView.userInteractionEnabled = YES;
    [view addSubview:bottomView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0.0f, bottomView.frame.size.height - leftArrow.size.height, leftArrow.size.width, leftArrow.size.height);
    [leftButton setImage:leftArrow forState:UIControlStateNormal];
    [bottomView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(bottomView.frame.size.width - rightArrow.size.width, bottomView.frame.size.height - rightArrow.size.height, rightArrow.size.width, rightArrow.size.height);
    [rightButton setImage:rightArrow forState:UIControlStateNormal];
    [bottomView addSubview:rightButton];
}

+ (void)applySixthGreenThemeWithView:(UIView *)view navItem:(UINavigationItem *)navItem navBar:(UINavigationBar *)navBar {
    
    UIImage *backgroundImage = [UIImage imageNamed:@"6-green-background.jpg"];
    UIImage *settingsButtonImage = [UIImage imageNamed:@"6-green-settings-button.png"];
    UIImage *bottomMenuImage = [UIImage imageNamed:@"6-green-menu-bar.png"];
    UIImage *leftArrow = [UIImage imageNamed:@"6-green-back-arrow.png"];
    UIImage *rightArrow = [UIImage imageNamed:@"6-green-forward-arrow.png"];
    
    [self applySixthThemeWithView:view navItem:navItem navBar:navBar backgroundImage:backgroundImage settingsButtonImage:settingsButtonImage bottomMenuImage:bottomMenuImage leftArrow:leftArrow rightArrow:rightArrow];
}


@end
