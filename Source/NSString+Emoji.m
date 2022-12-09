//
//  NSString+SMSCounter.m
//  Pods
//
//  Created by Mahesh on 07/12/22.
//

#import "NSString+Emoji.h"

@implementation NSString(Emoji)

- (NSArray *)getExtendedGSMCharacter
{
    static NSArray *extendedGSMCharacter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        extendedGSMCharacter = @[@"\f", @"|", @"^", @"{", @"}", @"€", @"[", @"~", @"]", @"\\"];
    });
    return extendedGSMCharacter;
}

- (BOOL)stringContainsEmoji {
    
    __block BOOL containsEmoji = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop){
        
        const unichar hs = [substring characterAtIndex:0];
        const unichar ls = substring.length > 1 ? [substring characterAtIndex:1] : 0;
        
    #define IS_IN(val, min, max) (((val) >= (min)) && ((val) <= (max)))
        
        if(IS_IN(hs, 0xD800, 0xDBFF))
        {
            if(substring.length > 1)
            {
                const int uc = ((hs - 0xD800) * 0x400) + (ls - 0xDC00) + 0x10000;
                
                // Musical: [U+1D000, U+1D24F]
                // Enclosed Alphanumeric Supplement: [U+1F100, U+1F1FF]
                // Enclosed Ideographic Supplement: [U+1F200, U+1F2FF]
                // Miscellaneous Symbols and Pictographs: [U+1F300, U+1F5FF]
                // Supplemental Symbols and Pictographs: [U+1F900, U+1F9FF]
                // Emoticons: [U+1F600, U+1F64F]
                // Transport and Map Symbols: [U+1F680, U+1F6FF]
                if(IS_IN(uc, 0x1D000, 0x1F9FF))
                    containsEmoji = YES;
            }
        }
        else if(substring.length > 1 && ls == 0x20E3)
        {
            // emojis for numbers: number + modifier ls = U+20E3
            containsEmoji = YES;
        }
        else
        {
            if(        // Latin-1 Supplement
               hs == 0x00A9 || hs == 0x00AE
               // General Punctuation
               ||  hs == 0x203C || hs == 0x2049
               // Letterlike Symbols
               ||  hs == 0x2122 || hs == 0x2139
               // Arrows
               ||  IS_IN(hs, 0x2194, 0x2199) || IS_IN(hs, 0x21A9, 0x21AA)
               // Miscellaneous Technical
               ||  IS_IN(hs, 0x231A, 0x231B) || IS_IN(hs, 0x23E9, 0x23F3) || IS_IN(hs, 0x23F8, 0x23FA) || hs == 0x2328 || hs == 0x23CF
               // Geometric Shapes
               ||  IS_IN(hs, 0x25AA, 0x25AB) || IS_IN(hs, 0x25FB, 0x25FE) || hs == 0x25B6 || hs == 0x25C0
               // Miscellaneous Symbols
               ||  IS_IN(hs, 0x2600, 0x2604) || IS_IN(hs, 0x2614, 0x2615) || IS_IN(hs, 0x2622, 0x2623) || IS_IN(hs, 0x262E, 0x262F)
               ||  IS_IN(hs, 0x2638, 0x263A) || IS_IN(hs, 0x2648, 0x2653) || IS_IN(hs, 0x2665, 0x2666) || IS_IN(hs, 0x2692, 0x2694)
               ||  IS_IN(hs, 0x2696, 0x2697) || IS_IN(hs, 0x269B, 0x269C) || IS_IN(hs, 0x26A0, 0x26A1) || IS_IN(hs, 0x26AA, 0x26AB)
               ||  IS_IN(hs, 0x26B0, 0x26B1) || IS_IN(hs, 0x26BD, 0x26BE) || IS_IN(hs, 0x26C4, 0x26C5) || IS_IN(hs, 0x26CE, 0x26CF)
               ||  IS_IN(hs, 0x26D3, 0x26D4) || IS_IN(hs, 0x26D3, 0x26D4) || IS_IN(hs, 0x26E9, 0x26EA) || IS_IN(hs, 0x26F0, 0x26F5)
               ||  IS_IN(hs, 0x26F7, 0x26FA)
               ||  hs == 0x260E || hs == 0x2611 || hs == 0x2618 || hs == 0x261D || hs == 0x2620 || hs == 0x2626 || hs == 0x262A
               ||  hs == 0x2660 || hs == 0x2663 || hs == 0x2668 || hs == 0x267B || hs == 0x267F || hs == 0x2699 || hs == 0x26C8
               ||  hs == 0x26D1 || hs == 0x26FD
               // Dingbats
               ||  IS_IN(hs, 0x2708, 0x270D) || IS_IN(hs, 0x2733, 0x2734) || IS_IN(hs, 0x2753, 0x2755)
               ||  IS_IN(hs, 0x2763, 0x2764) || IS_IN(hs, 0x2795, 0x2797)
               ||  hs == 0x2702 || hs == 0x2705 || hs == 0x270F || hs == 0x2712 || hs == 0x2714 || hs == 0x2716 || hs == 0x271D
               ||  hs == 0x2721 || hs == 0x2728 || hs == 0x2744 || hs == 0x2747 || hs == 0x274C || hs == 0x274E || hs == 0x2757
               ||  hs == 0x27A1 || hs == 0x27B0 || hs == 0x27BF
               // CJK Symbols and Punctuation
               ||  hs == 0x3030 || hs == 0x303D
               // Enclosed CJK Letters and Months
               ||  hs == 0x3297 || hs == 0x3299
               // Supplemental Arrows-B
               ||  IS_IN(hs, 0x2934, 0x2935)
               // Miscellaneous Symbols and Arrows
               ||  IS_IN(hs, 0x2B05, 0x2B07) || IS_IN(hs, 0x2B1B, 0x2B1C) || hs == 0x2B50 || hs == 0x2B55
               )
            {
                containsEmoji = YES;
            }
        }
    #undef IS_IN
        if (containsEmoji)
        {
            *stop = YES;
        }
    }];
    
    return containsEmoji;
}
//- (BOOL)stringContainsExtendedGSMCharacter {
//
//    __block BOOL returnValue = NO;
//    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
//                               options:NSStringEnumerationByComposedCharacterSequences
//                            usingBlock:^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop){
//        if ([[self getExtendedGSMCharacter] containsObject:substring] ){
//            returnValue = YES;
//        }
//
//    }];
//
//    return returnValue;
//}

- (int)lengthOfSMS {
    //NSString *text = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    __block int length = 0;
    
    
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop){
        if ([[self getExtendedGSMCharacter] containsObject:substring] ){
            length = length + 2;
        }else {
            length = length + (int) substring.length;
        }
    }];
    return length;
    
}


@end
