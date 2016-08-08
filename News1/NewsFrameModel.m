//
//  NewsFrameModel.m
//  News
//
//  Created by tom555cat on 16/8/5.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import "NewsFrameModel.h"

@implementation NewsFrameModel

+ (instancetype)frameModelWithModel:(NewsModel *)model
{
    return [[self alloc] initWithModel:model];
}

+ (NSMutableArray *)frameModelWithArray:(NSMutableArray *)arr
{
    NSMutableArray *data = [NSMutableArray array];
    for (NewsModel *model in arr) {
        NewsFrameModel *frameModel = [self frameModelWithModel:model];
        [data addObject:frameModel];
    }
    
    return data;
}

- (instancetype)initWithModel:(NewsModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    
    return self;
}

- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        CGSize winSize = [UIScreen mainScreen].bounds.size;
        CGFloat margin = 10;
        
        // 图片
        CGFloat picX = margin;
        CGFloat picY = margin;
        CGFloat picH = 70;
        CGFloat picW = picH * 1.2;
        self.picFrame = CGRectMake(picX, picY, picW, picH);
        
        // 标题
        CGFloat titleX = CGRectGetMaxX(self.picFrame) + margin;
        CGFloat titleY = margin;
        CGFloat titleW = winSize.width - margin * 3 - picW;
        CGFloat titleH = picH / 2.0f;
        self.titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
        
        // 作者
        CGFloat authorX = CGRectGetMaxX(self.picFrame) + margin;
        CGFloat authorY = CGRectGetMaxY(self.picFrame) - picH * 0.2f;
        CGFloat authorW = titleW;
        CGFloat authorH = picH * 0.2;
        self.authorFrame = CGRectMake(authorX, authorY, authorW, authorH);
        
        _cellHeight = CGRectGetMaxY(self.picFrame) + margin;
    }
    
    return _cellHeight;
}

@end
