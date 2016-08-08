//
//  GuGuSegmentNaviViewController.h
//  News1
//
//  Created by tom555cat on 16/8/7.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuGuSegmentBarView.h"

@interface GuGuSegmentNaviViewController : UIViewController <GuGuIndexDelegate>

-(id)initWithItems:(NSArray*)titleArray andControllers:(NSArray*)controllers;

@end
