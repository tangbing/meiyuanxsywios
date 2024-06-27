//
//  ZSSYLSTestViewController.m
//  EduciotZSSY
//
//  Created by lilisheng on 2019/11/13.
//  Copyright © 2019 YuLianWang. All rights reserved.
//

#import "ZSSYLSTestViewController.h"


#import "ZSSYFaceTemperatureListVC.h"//人脸识别
#import "ZSSYFaceTemperatureDetailsVC.h"//人脸识别
#import "ZSSYFaceTempRecordsListVC.h"//人脸识别-记录
#import "ZSSYFaceTempSChoolListVC.h"//统计-全校
#import "ZSSYFaceTempClassListVC.h"

@interface ZSSYLSTestViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) NSMutableArray<NSString *> *data;
@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) InputImgOrTextButton *inputButton;

@property (nonatomic, strong) NSArray    *selectArray;

@end

@implementation ZSSYLSTestViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试2" style:0 target:self action:@selector(test)];
}
-(void)test{

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试页面";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self p_addMasonry];
    
    self.data = @[
        @"统计-全校",
        @"统计-班级",
        @"记录",
        @"详情",
        @"啥子",
        ].mutableCopy;
}

#pragma mark - # Delegate
//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}
#pragma mark - # Private Methods
- (void)p_addMasonry {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    id vc = nil;
    
    if ([self.data[indexPath.row] isEqualToString:@"统计-全校"]) {
        vc = [ZSSYFaceTempSChoolListVC new];
    }
    else if ([self.data[indexPath.row] isEqualToString:@"统计-班级"]) {
        vc = [ZSSYFaceTempClassListVC new];
    }
    else if ([self.data[indexPath.row] isEqualToString:@"记录"]) {
        vc = [ZSSYFaceTempRecordsListVC new];
    }
    else if ([self.data[indexPath.row] isEqualToString:@"详情"]) {
        vc = [[ZSSYFaceTemperatureDetailsVC alloc] initWithNibName:@"ZSSYFaceTemperatureDetailsVC" bundle:[NSBundle mainBundle]];
    }
    else if ([self.data[indexPath.row] isEqualToString:@"啥子"]) {
        ZSSYFaceTemperatureListVC *VC = [ZSSYFaceTemperatureListVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    [self.navigationController pushViewController:vc animated:true];
}


#pragma mark - # Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
}

@end
