//
//  TableViewCell.h
//  AutoResizeTextView
//
//  Created by ZhuiYi on 15/2/13.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableViewCellDelegate;

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) id<TableViewCellDelegate> delegate;

+ (TableViewCell *)createCell;
@end

@protocol TableViewCellDelegate <NSObject>
/**
 *  改变文字时更新模型
 *
 *  @param cell 正在编辑的cell
 *  @param text textView中的文字
 */
- (void)tableViewCell:(TableViewCell *)cell didChangeText:(NSString *)text;
/**
 *  开始编辑时执行滚动
 *
 *  @param cell 编辑的cell
 *  @param text textView中的文字
 */
- (void)tableViewCell:(TableViewCell *)cell didBeginEditingText:(NSString *)text;
@end
