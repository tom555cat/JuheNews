//
//  NewsTableViewCell.h
//  News
//
//  Created by tom555cat on 16/8/5.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "NewsFrameModel.h"

@interface NewsTableViewCell : UITableViewCell

@property (nonatomic, strong) NewsModel *model;
@property (nonatomic, strong) NewsFrameModel *frameModel;

@end
