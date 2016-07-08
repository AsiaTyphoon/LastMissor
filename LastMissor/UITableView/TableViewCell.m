//
//  TableViewCell.m
//  LastMissor
//
//  Created by HXjiang on 16/7/8.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()
{
    CGFloat w;
    CGFloat h;
}

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        w = [UIScreen mainScreen].bounds.size.width;
        h = cellh;
        
        [self.contentView addSubview:self.labtext];
    }
    return self;
}

- (UILabel *)labtext {
    if (!_labtext) {
        _labtext = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        _labtext.textAlignment = NSTextAlignmentCenter;
        _labtext.font = [UIFont systemFontOfSize:12];
    }
    return _labtext;
}


@end
