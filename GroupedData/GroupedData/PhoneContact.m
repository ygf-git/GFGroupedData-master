//
//  PhoneContact.m
//  GroupedData
//
//  Created by 杨桂福 on 2021/3/18.
//

#import "PhoneContact.h"
#import "PinyinConverter.h"

@implementation PhoneContact

- (void)setContact:(CNContact *)contact {
    _name = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
}

- (UIImage *)iconImage {
    if (!_iconImage) {
        _iconImage = [self imageWithText:self.name];
    }
    return _iconImage;
}

#pragma mark --- BaseContactProtocol
- (NSString *)groupTitle{
    NSString *sort = [PinyinConverter toPinyin:self.name];
    NSString *sortStr = [sort length] ? [sort substringWithRange:NSMakeRange(0, 1)] : @"";
    NSString *title = sortStr.localizedCapitalizedString;
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    if ([[collation sectionTitles] containsObject:title]) {
        return title;
    }else{
        return @"#";
    }
}

- (NSString *)showName{
    return self.name;
}

- (UIImage *)imageWithText:(NSString *)name {

    name=[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSString *text = name.length > 0 ? [name.uppercaseString substringToIndex:1] : name.uppercaseString;

    NSDictionary *fontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.f weight:UIFontWeightMedium], NSForegroundColorAttributeName: [UIColor whiteColor]};

    CGSize textSize = [text sizeWithAttributes:fontAttributes];

    CGPoint drawPoint = CGPointMake((36 - textSize.width)/2, (36 - textSize.height)/2);

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(36, 36), NO, 0.0);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 36, 36) cornerRadius:4];

    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:((0x45A5D9 & 0xFF0000) >> 16) / 255.0f
                                                        green:((0x45A5D9 & 0xFF00) >> 8) / 255.0f
                                                         blue:(0x45A5D9 & 0xFF) / 255.0f
                                                        alpha:1].CGColor);

    [path fill];

    [text drawAtPoint:drawPoint withAttributes:fontAttributes];

    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return resultImg;
}

@end
