//
//  TableViewCell.m
//  AutoResizeTextView
//
//  Created by ZhuiYi on 15/2/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "TableViewCell.h"
@interface TableViewCell()<UITextViewDelegate>

@end

@implementation TableViewCell

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:didBeginEditingText:)]) {
        [self.delegate tableViewCell:self didBeginEditingText:self.textField.text];
    }
}

+ (TableViewCell *)createCell
{
    TableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil] lastObject];
    
    return cell;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:didChangeText:)]) {
        [self.delegate tableViewCell:self didChangeText:self.textField.text];
    }
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
    // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

@end
