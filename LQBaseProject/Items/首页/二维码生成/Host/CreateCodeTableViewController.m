//  CreateCodeTableViewController.m
//  LQBaseProject
//  Created by YZR on 16/7/7.
//  Copyright © 2016年 YZR. All rights reserved.

#import "CreateCodeTableViewController.h"
#import "LXDBarCodeViewController.h"
#import "OriBarCodeViewController.h"
#import "BarCodeHostVC.h"//二维码和条形码（网络）

@interface CreateCodeTableViewController (){

    NSArray *_titleArray;
}

@end

@implementation CreateCodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mTableViewSetting];
    
    _titleArray = @[@"1 - ",@"2 - ",@"3 - 生成二维码和条形码"];
}

-(void)mTableViewSetting{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //去掉尾部分割线
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //分割线偏移
    self.tableView.separatorInset = UIEdgeInsetsMake(0,20, 0, 20);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_titleArray[indexPath.row]];
    return cell;
}

#pragma mark - cell 点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //中间带图片的二维码生成,也可以不带
        LXDBarCodeViewController *vc = [LXDBarCodeViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){//单个二维码不带效果的(使用系统的方法)
        OriBarCodeViewController *vc2 = [OriBarCodeViewController new];
        [self.navigationController pushViewController:vc2 animated:YES];
    }else if (indexPath.row == 2){
        //网上的二维码和条形码
        BarCodeHostVC *vc = [BarCodeHostVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
