//
//  ThemeManager.h
//  SOP
//
//  Created by Matt McAlear on 4/3/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject

+ (void)applySixthThemeWithView:(UIView *)view navItem:(UINavigationItem *)navItem navBar:(UINavigationBar *)navBar backgroundImage:(UIImage *)backgroundImage settingsButtonImage:(UIImage *)settingsButtonImage bottomMenuImage:(UIImage *)bottomMenuImage leftArrow:(UIImage *)leftArrow rightArrow:(UIImage *)rightArrow;

+ (void)applySixthGreenThemeWithView:(UIView *)view navItem:(UINavigationItem *)navItem navBar:(UINavigationBar *)navBar;


@end
