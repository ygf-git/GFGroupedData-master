# GroupedData - 全网最好用的通讯录联系人排序算法，支持多语言索引排序,接入简单方便无耦合，只需Mode遵守Protocol即可实现排序（pod 更新至 0.0.1）

![索引.GIF](https://upload-images.jianshu.io/upload_images/14803664-843da8f83d0c3953.GIF?imageMogr2/auto-orient/strip)

用法
==============

### 遵守协议

    @interface Model : NSObject<BaseContactProtocol>


### 实现协议中的方法

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

### 获取整理后的数据

    GroupedData *groupedData = [[GroupedData alloc] init];
    groupedData.members = myPhoneContacts;
    self.contentDic = groupedData.contentDic;
    self.titles = groupedData.sectionTitles;

### 排序算法看demo

### 依赖
无任何依赖 

安装
==============

### CocoaPods  
1. 将 cocoapods 更新至最新版本.
2. 在 Podfile 中添加 pod 'GroupedData', '~> 0.0.1'
3. 执行 `pod install` 或 `pod update`。
4. 导入 #import "GroupData.h"

### 手动安装

1. 下载 GroupedData 文件夹内的所有内容。
2. 将 GroupedData 内的源文件添加(拖放)到你的工程。
3. 导入 #import "GroupData.h"

系统要求
==============
该库最低支持 `iOS 9.0` 和 `Xcode 9.0`。

许可证
==============
GroupedData 使用 MIT 许可证，详情见 [LICENSE](LICENSE) 文件。


个人主页
==============
使用过程中如果有什么bug欢迎给我提issue 我看到就会解决
[我的简书](https://www.jianshu.com/u/5f7f0b837a4f)

更新日记
==============
- 20210319 提交开源库，欢迎大家使用
