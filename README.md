# JuheNews
聚合新闻API调用IOS客户端

聚合新闻API地址：https://www.juhe.cn/docs/api/id/235

请求URL格式：http://v.juhe.cn/toutiao/index?type=top&key=APPKEY
top是新闻类型，APPKEY是申请的个人KEY。

返回数据为JSON格式：
```
{
    "reason": "成功的返回",
    "result": {
        "stat": "1",
        "data": [
            {
                "title": "巫山云雨枉断肠：女摄影师Erika Lust记录的性爱",/*标题*/
                "date": "2016-06-13 10:31",/*时间*/
                "author_name": "POCO摄影",/*作者*/
                "thumbnail_pic_s": "",/*图片1*/
                "thumbnail_pic_s02": "",/*图片2*/
                "thumbnail_pic_s03": "",/*图片3*/
                "url": "",/*新闻链接*/
                "uniquekey": "160613103108379",/*唯一标识*/
                "type": "头条",/*类型一*/
                "realtype": "娱乐"/*类型二*/
            },
...]}}
```

该项目使用了仿网易新闻的界面框架，在每一个新闻标签页，使用AFNetworking获取相关的新闻：

```
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
```

解析JSON：
```
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

```

在使用仿网易新闻的界面框架时，在每一个标签页内，点击tableView中的一项时，无法获取到self.navigationController，所以将对应的UIViewController取出来，让上一层的UIViewController去push。

```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.newsArray[indexPath.row];
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.urlStr = model.url;
    [self.delegate pushNewsVC:newsVC];
}
```
