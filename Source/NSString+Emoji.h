//
//  NSString+SMSCounter.h
//  Pods
//
//  Created by Mahesh on 07/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString(Emoji)

/**
 Calculate if the string has any emoji.
 
 @return YES if the string has emojis, No otherwise.
 */
- (BOOL)stringContainsEmoji;
/**
 Calculate length of the sms string .
 
 @return total length of sms string.
 */
- (int)lengthOfSMS;
@end

NS_ASSUME_NONNULL_END
