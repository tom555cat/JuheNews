//
//  GuGuSegmentNaviViewController.m
//  News1
//
//  Created by tom555cat on 16/8/7.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import "GuGuSegmentNaviViewController.h"
#import "GuGuLandscapeTableView.h"

#define kBarHeight 27
@interface GuGuSegmentNaviViewController ()

@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) NSArray *_titleArray;
@property (nonatomic, strong) GuGuLandscapeTableView *contentTable;
@property (nonatomic, strong) GuGuSegmentBarView *barView ;

@end

@implementation GuGuSegmentNaviViewController

-(id)initWithItems:(NSArray*)titleArray andControllers:(NSArray*)controllers
{
    self = [super init];
    if (self)
    {
        NSString * tmpVersonType = [UIDevice currentDevice].systemVersion;
        
        NSArray * tmpArr = [tmpVersonType componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
        int y = 0;
        if([[tmpArr objectAtIndex:0] isEqualToString:@"7"])
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
            y = 64;
        }
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        y = 64;
        
        // BarView
        CGSize winSize = [UIScreen mainScreen].bounds.size;
        _barView = [[GuGuSegmentBarView alloc]initWithFrame:CGRectMake(0, y, winSize.width, kBarHeight) andItems:titleArray];
        
        _barView.backgroundColor = RGBCOLOR(230, 230, 230);
        [self.view addSubview:_barView];
        _barView.clickDelegate = self;
        self.view.backgroundColor = [UIColor whiteColor];
        _contentTable = [[GuGuLandscapeTableView alloc]initWithFrame:CGRectMake(0,  kBarHeight + y, winSize.width, self.view.frame.size.height - kBarHeight - y) Array:controllers];
        _contentTable.swipeDelegate = self;
        
        [self.view addSubview:_contentTable];
        
        
        if (controllers.count > 0)
        {
            for (UIViewController *controller  in controllers)
            {
                //[self addChildViewController:controller];
            }
            _currentIndex = 0;
        }
        __titleArray = titleArray;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [__titleArray objectAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------- GuGuIndexDelegate -----------------

-(void)barSelectedIndexChanged:(int)newIndex
{
    if (newIndex >= 0)
    {
        _currentIndex = newIndex;
        self.title = [__titleArray objectAtIndex:newIndex];
        [_contentTable selectIndex:newIndex];
    }
}

-(void)contentSelectedIndexChanged:(int)newIndex
{
    [_barView selectIndex:newIndex];
}

-(void)scrollOffsetChanged:(CGPoint)offset
{
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    int page = (int)offset.y / winSize.width ;
    float radio = (float)((int)offset.y % (int)winSize.width)/(int)winSize.width;
    [_barView setLineOffsetWithPage:page andRatio:radio];
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
