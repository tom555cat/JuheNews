//
//  NewsFrameModel.h
//  News
//
//  Created by tom555cat on 16/8/5.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsFrameModel : NSObject

@property (nonatomic, assign) CGRect picFrame;
@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect authorFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NewsModel *model;

+ (NSMutableArray *)frameModelWithArray:(NSMutableArray *)arr;

+ (instancetype)frameModelWithModel:(NewsModel *)model;

@end
