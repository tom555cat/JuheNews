//
//  ShowViewController.m
//  SDPagesSelector
//
//  Created by tom555cat on 16/7/15.
//  Copyright © 2016年 songdh. All rights reserved.
//

#import "ShowViewController.h"
#import "NewsTableViewCell.h"
#import "AFNetworking.h"
#import "NewsViewController.h"

static NSString *IDD = @"newsTableViewCell";

@interface ShowViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, strong) NSMutableArray *newsFrameArray;
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [self randomColor];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    _contentLabel.center = self.view.center;
    _contentLabel.textColor = [UIColor redColor];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.text = self.content;
    [self.view addSubview:_contentLabel];
    
    // 添加消息tableView
    [self.view addSubview:self.tableView];
    
    // 添加新闻
    [self getNews];
}

- (void)getNews
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"type":self.urlTag,@"key":@"4aff81d23b8e830f41df3f90eb3c0b53"};
    NSString *urlStr1 = @"http://v.juhe.cn/toutiao/index";
    [manager GET:urlStr1 parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *newDic = [responseObject valueForKeyPath:@"result"];
        NSArray *newsArray = newDic[@"data"];
        [self extractNewsData:newsArray];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)extractNewsData:(NSArray *)newsArray
{
    for (NSInteger i = 0; i < [newsArray count]; i++) {
        NewsModel *model = [[NewsModel alloc] init];
        model.title = newsArray[i][@"title"];
        model.date = newsArray[i][@"date"];
        model.authorName = newsArray[i][@"author_name"];
        model.thumbnailPicS01 = newsArray[i][@"thumbnail_pic_s"];
        model.thumbnailPicS02 = newsArray[i][@"thumbnail_pic_s02"];
        model.thumbnailPicS03 = newsArray[i][@"thumbnail_pic_s03"];
        model.url = newsArray[i][@"url"];
        model.uniqueKey = newsArray[i][@"uniquekey"];
        model.type = newsArray[i][@"type"];
        model.realType = newsArray[i][@"realtype"];
        
        [self.newsArray addObject:model];
        
        //NSLog(@"%@", model.url);
    }
    self.newsFrameArray = [NewsFrameModel frameModelWithArray:self.newsArray];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *)randomColor
{
    static BOOL seeded = NO;
    if(!seeded) {
        seeded = YES;
        srandom((unsigned)time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        CGSize winSize = [UIScreen mainScreen].bounds.size;
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = winSize.width;
        CGFloat height = winSize.height - 64 - 40;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        NSLog(@"vc x: %f, y: %f", self.view.frame.origin.x, self.view.frame.origin.y);
        NSLog(@"vc width: %f, height: %f", self.view.frame.size.width, self.view.frame.size.height);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:IDD];
    }
    
    return _tableView;
}

#pragma mark ------------ tableViewDelegate ---------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.newsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDD];
    cell.model = [self.newsArray objectAtIndex:indexPath.row];
    cell.frameModel = [self.newsFrameArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsFrameModel *frameModel = self.newsFrameArray[indexPath.row];
    return  frameModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.newsArray[indexPath.row];
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.urlStr = model.url;
    [self.delegate pushNewsVC:newsVC];
    /*
    if (self.navigationController != nil) {
        [self.navigationController pushViewController:newsVC animated:YES];
    } else {
        NSLog(@"不存在!!!");
    }
    */
    
    //[self presentViewController:newsVC animated:YES completion:nil ];
}

#pragma mark -------------- getter & setter ----------------

- (NSMutableArray *)newsArray
{
    if (!_newsArray) {
        _newsArray = [[NSMutableArray alloc] init];
    }
    
    return _newsArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
