//
//  NewsModel.h
//  News
//
//  Created by tom555cat on 16/8/5.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *thumbnailPicS01;
@property (nonatomic, strong) NSString *thumbnailPicS02;
@property (nonatomic, strong) NSString *thumbnailPicS03;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *uniqueKey;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *realType;

@end
