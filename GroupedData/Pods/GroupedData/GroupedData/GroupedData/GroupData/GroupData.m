//
//  GroupedData.m
//  GroupedData
//
//  Created by 杨桂福 on 2021/3/18.
//

#import "GroupData.h"

@interface ContactsPair : NSObject

@property (nonatomic, strong) id first;

@property (nonatomic, strong) id second;

@end

@implementation ContactsPair

- (instancetype)initWithFirst:(id)first second:(id)second {
    self = [super init];
    if(self) {
        _first = first;
        _second = second;
    }
    return self;
}

@end

@interface GroupedData ()

@property (nonatomic, strong) NSMutableOrderedSet *groupTtiles;

@property (nonatomic, strong) NSMutableOrderedSet *groups;

@property (nonatomic, copy) NSComparator groupTitleComparator;

@property (nonatomic, copy) NSComparator groupMemberComparator;

@end

@implementation GroupedData

- (instancetype)init {
    if (self = [super init]) {
        _members = @[].mutableCopy;
        _groupTtiles = [[NSMutableOrderedSet alloc] init];
        _groups = [[NSMutableOrderedSet alloc] init];
        _groupTitleComparator = ^NSComparisonResult(NSString *title1, NSString *title2) {
            if ([title1 isEqualToString:@"#"]) {
                return NSOrderedDescending;
            }else if ([title2 isEqualToString:@"#"]) {
                return NSOrderedAscending;
            }else{
                return [title1 localizedCompare:title2];
            }
        };
        _groupMemberComparator = ^NSComparisonResult(NSString *key1, NSString *key2) {
            return [key1 localizedCompare:key2];
        };
    }
    return self;
}

- (void)setMembers:(NSArray *)members {
    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    for (id<BaseContactProtocol>member in members) {
        NSString *groupTitle = [member groupTitle];
        NSMutableArray *groupedMembers = [tmp objectForKey:groupTitle];
        if(!groupedMembers) {
            groupedMembers = [NSMutableArray array];
        }
        [groupedMembers addObject:member];
        [tmp setObject:groupedMembers forKey:groupTitle];
    }
    [_groupTtiles removeAllObjects];
    [_groups removeAllObjects];
    
    [tmp enumerateKeysAndObjectsUsingBlock:^(NSString *groupTitle, NSMutableArray *groupedMembers, BOOL *stop) {
        if (groupTitle.length) {
            [_groupTtiles addObject:groupTitle];
            [_groups addObject:[[ContactsPair alloc] initWithFirst:groupTitle second:groupedMembers]];
        }
    }];
    
    [self sortGroup];
    
    NSMutableArray *totalMember = [NSMutableArray array];
    for (int i = 0; i < _groups.count; ++i) {
        NSArray *tempArr = [self membersOfGroup:i];
        [totalMember addObjectsFromArray:tempArr];
    }
    _members = totalMember;
}

#pragma mark - Getter
- (NSArray *)sectionTitles {
    return [_groupTtiles array];
}

- (NSDictionary *)contentDic {
    NSDictionary *dic = @{}.mutableCopy;
    for (int i = 0; i < _groups.count; ++i) {
        NSArray *tempArr = [self membersOfGroup:i];
        NSString *title = [self titleofGroup:i];
        [tempArr enumerateObjectsUsingBlock:^(id<BaseContactProtocol>member, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *arr = [dic valueForKey:title];
            if (!arr) {
                arr = @[].mutableCopy;
                [dic setValue:arr forKey:title];
            }
            [arr addObject:member];
        }];
    }
    return dic;
}

#pragma mark - Private
- (NSString *)titleofGroup:(NSInteger)groupIndex {
    if(groupIndex >= 0 && groupIndex < _groupTtiles.count) {
        return [_groupTtiles objectAtIndex:groupIndex];
    }
    return nil;
}

- (NSArray *)membersOfGroup:(NSInteger)groupIndex
{
    if(groupIndex >= 0 && groupIndex < _groups.count) {
        ContactsPair *pair = [_groups objectAtIndex:groupIndex];
        return pair.second;
    }
    return nil;
}

- (void)sortGroup
{
    [self sortGroupTitle];
    [self sortGroupMember];
}

- (void)sortGroupTitle
{
    [_groupTtiles sortUsingComparator:_groupTitleComparator];
    [_groups sortUsingComparator:^NSComparisonResult(ContactsPair *pair1, ContactsPair *pair2) {
        return _groupTitleComparator(pair1.first, pair2.first);
    }];
}

- (void)sortGroupMember
{
    [_groups enumerateObjectsUsingBlock:^(ContactsPair *obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray *groupedMembers = obj.second;
        [groupedMembers sortUsingComparator:^NSComparisonResult(id<BaseContactProtocol> member1, id<BaseContactProtocol> member2) {
            return _groupMemberComparator([member1 showName], [member2 showName]);
        }];
    }];
}

@end

