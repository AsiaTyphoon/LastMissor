//
//  FriendViewCell.m
//  LastMissor
//
//  Created by HXjiang on 16/9/8.
//  Copyright © 2016年 JiangLin. All rights reserved.
//

#import "FriendViewCell.h"
#import "Masonry.h"

@implementation FriendViewCell

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
        
        
        //self.backgroundColor = [UIColor orangeColor];
        
        __weak typeof(self) weakSelf = self;
        
        self.iconImageView = [UIImageView new];
        
        [self.contentView addSubview:self.iconImageView];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            
            make.size.mas_equalTo(CGSizeMake(100, 100));
            
            //make.bottom.mas_greaterThanOrEqualTo(-10);
            
            //make.width.equalTo(weakSelf.iconImageView.mas_height);
        }];
        
        
        
        self.titleLabel = [UILabel new];
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        //self.titleLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(5);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.right.mas_equalTo(-5);
            make.height.mas_greaterThanOrEqualTo(weakSelf.iconImageView.mas_height);
        }];
        
        
    }
    return self;
}


@end
