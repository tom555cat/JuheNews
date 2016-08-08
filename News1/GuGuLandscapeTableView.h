//
//  GuGuLandscapeTableView.h
//  News1
//
//  Created by tom555cat on 16/8/7.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuGuSegmentBarView.h"

@interface GuGuLandscapeTableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,retain)NSArray *cellDataSource;

- (void)reloadTableWithArray:(NSArray*)array;
- (id)initWithFrame:(CGRect)frame Array:(NSArray*)array;
-(void)selectIndex:(int)index;

@property (nonatomic,unsafe_unretained) id<GuGuIndexDelegate>swipeDelegate;

@end
