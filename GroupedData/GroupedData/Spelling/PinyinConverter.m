//
//  PinyinConverter.m
//  GroupedData
//
//  Created by 杨桂福 on 2021/3/18.
//

#import "PinyinConverter.h"
#import "PinYin4Objc.h"

@implementation PinyinConverter

+ (NSString *)toPinyin:(NSString *)source
{
    if ([source length] == 0)
    {
        return nil;
    }
    
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:source withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
    
    return outputPinyin;
}

@end
