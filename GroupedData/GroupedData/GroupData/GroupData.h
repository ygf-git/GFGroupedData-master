//
//  GroupedData.h
//  GroupedData
//
//  Created by 杨桂福 on 2021/3/18.
//


#import <Foundation/Foundation.h>
#import "BaseContactProtocol.h"


@interface GroupedData : NSObject

@property(nonatomic, strong) NSArray *members;

@property(nonatomic, readonly) NSArray *sectionTitles;

@property(nonatomic, readonly) NSDictionary *contentDic;

@end
