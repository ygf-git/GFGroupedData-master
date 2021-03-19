//
//  PhoneContact.h
//  GroupedData
//
//  Created by 杨桂福 on 2021/3/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>
#import "BaseContactProtocol.h"

@interface PhoneContact : NSObject<BaseContactProtocol>

@property (nonatomic,  copy) NSString  *name;

@property (nonatomic,strong) UIImage   *iconImage;

@property (nonatomic,strong) CNContact *contact;

@end
