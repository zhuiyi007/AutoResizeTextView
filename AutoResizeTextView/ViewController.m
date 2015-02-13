//
//  ViewController.m
//  AutoResizeTextView
//
//  Created by ZhuiYi on 15/2/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()<TableViewCellDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"cell1", @"cell2", @"cell3", @"cell4", @"cell5", @"cell6", nil];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // tableView自动改变高度
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [TableViewCell createCell];
    }
    cell.delegate = self;
    cell.textField.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - 当cell中的textView中文字改变时更新模型,防止重用时出错
- (void)tableViewCell:(TableViewCell *)cell didChangeText:(NSString *)text
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSMutableArray *data = [self.dataArray mutableCopy];
    data[indexPath.row] = text;
    self.dataArray = [data copy];
}

#pragma mark - 开始编辑时滚动到最上方,防止过长时出现问题
- (void)tableViewCell:(TableViewCell *)cell didBeginEditingText:(NSString *)text
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


@end
