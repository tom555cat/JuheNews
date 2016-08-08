//
//  ShowViewController.h
//  SDPagesSelector
//
//  Created by 宋东昊 on 16/7/15.
//  Copyright © 2016年 songdh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PushNewsVCDelegate <NSObject>

- (void)pushNewsVC:(UIViewController *)showVC;

@end

@interface ShowViewController : UIViewController
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *urlTag;

@property (nonatomic, weak) id <PushNewsVCDelegate> delegate;
@end
