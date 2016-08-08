//
//  NewsTableViewCell.m
//  News
//
//  Created by tom555cat on 16/8/5.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface NewsTableViewCell ()

@property (nonatomic, weak) UIImageView *picImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *authorLabel;

@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *picImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:picImageView];
        self.picImageView = picImageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *authorLabel = [[UILabel alloc] init];
        authorLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:authorLabel];
        self.authorLabel = authorLabel;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _picImageView.frame = _frameModel.picFrame;
    _titleLabel.frame = _frameModel.titleFrame;
    _authorLabel.frame = _frameModel.authorFrame;
}

- (void)setModel:(NewsModel *)model
{
    _model = model;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnailPicS01]];
    _titleLabel.text = model.title;
    _authorLabel.text = model.authorName;
}

@end
