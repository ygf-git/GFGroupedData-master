//
//  ViewController.m
//  GroupedData
//
//  Created by 杨桂福 on 2021/3/18.
//

#import "ViewController.h"
#import "PhoneContact.h"
#import "GroupData.h"
#import <Contacts/Contacts.h>

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,copy)   NSArray *titles;

@property (nonatomic,strong) NSDictionary *contentDic;

@property (nonatomic,strong) UITableView  *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getGroupedData];
            });
        }
    }];
    [self getGroupedData];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)
                                                     style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.sectionIndexColor = [UIColor grayColor];
    [self.view addSubview:tableView];
}

- (void)getGroupedData {
    NSMutableArray *myPhoneContacts = [NSMutableArray array];
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusAuthorized) {
        NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey];
        // 创建CNContactFetchRequest对象
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            PhoneContact *phoneContact = [[PhoneContact alloc] init];
            phoneContact.contact = contact;
            [myPhoneContacts addObject:phoneContact];
        }];
    }
    
    GroupedData *groupedData = [[GroupedData alloc] init];
    groupedData.members = myPhoneContacts;
    self.contentDic = groupedData.contentDic;
    self.titles = groupedData.sectionTitles;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.contentDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [self.contentDic valueForKey:self.titles[section]];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSString *title = self.titles[indexPath.section];
    NSMutableArray *arr = [self.contentDic valueForKey:title];
    PhoneContact *contact = arr[indexPath.row];
    
    cell.imageView.image = contact.iconImage;
    cell.textLabel.text = contact.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titles[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.titles;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 64;
}

@end
