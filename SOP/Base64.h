//
//  Base64.h
//  SOP
//
//  Created by Matt McAlear on 3/10/13.
//  Copyright (c) 2013 Matt McAlear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSDataAdditions)
//for base 64 encoding
+ (NSData *) dataWithBase64EncodedString:(NSString *)string;
- (id) initWithBase64EncodedString:(NSString *)string;
- (NSString *) base64Encoding;
- (NSString *) base64EncodingWithLineLength:(unsigned int)lineLength;

//to convert NSData to hexadecimal string
#pragma mark - String Conversion
- (NSString *)hexadecimalString;
@end
