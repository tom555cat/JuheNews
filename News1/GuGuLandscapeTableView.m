//
//  GuGuLandscapeTableView.m
//  News1
//
//  Created by tom555cat on 16/8/7.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import "GuGuLandscapeTableView.h"

@implementation GuGuLandscapeTableView

@synthesize cellDataSource;
@synthesize swipeDelegate;
- (id)initWithFrame:(CGRect)frame Array:(NSArray*)array
{
    self = [super init];
    if (self)
    {
        self.frame = frame;
        
        self.backgroundColor = [UIColor redColor];
        _tableView = [[UITableView alloc]initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        _tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.pagingEnabled = YES;
        _tableView.backgroundColor = [UIColor colorWithRed:192/256.0 green:192/256.0 blue:192/256.0 alpha:1.0];
        _tableView.bounces =YES;
        [self addSubview:_tableView];
        self.cellDataSource = array;
        
    }
    return self;
}


- (void)reloadTableWithArray:(NSArray*)array
{
    if (array && array.count >0)
    {
        self.cellDataSource = array;
        [_tableView reloadData];
    }
}
#pragma mark Table view methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.width;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = self.cellDataSource.count;
    
    return rowCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ViewCell";
    
    UITableViewCell *cell = nil;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
        cell.contentView.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        UIViewController *vc = [cellDataSource objectAtIndex:[indexPath row]];
        vc.view.frame = cell.bounds;
        [cell.contentView addSubview:  vc.view];
    }
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.swipeDelegate != nil && [self.swipeDelegate respondsToSelector:@selector(contentSelectedIndexChanged:)])
    {
        int index = _tableView.contentOffset.y / self.frame.size.width;
        [self.swipeDelegate contentSelectedIndexChanged:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint pt =   _tableView.contentOffset;
    [self.swipeDelegate scrollOffsetChanged:pt];
}

-(void)selectIndex:(int)index
{
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
}


@end
