//
//  matterCell.m
//  TimeMaster
//
//  Created by GX on 15/2/7.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "matterCell.h"

@implementation matterCell
- (instancetype)initWithName:(NSString *)n AndDate:(NSString *)d AndViewWidth:(NSInteger) w{
    self = [super init];
    if (self) {
        self.backgroundColor = nil;
        //NSLog(@"%f",self.frame.size.width);
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, w - 26, self.bounds.size.height - 16)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = self.bounds.size.height / 12;
        bgView.clipsToBounds = YES;
        //NSLog(@"%f,%f",bgView.bounds.size.width,bgView.bounds.size.height);
        
        UILabel *day = [[UILabel alloc] initWithFrame:CGRectMake(bgView.bounds.size.width - bgView.bounds.size.height, 0, bgView.bounds.size.height, bgView.bounds.size.height)];
        day.backgroundColor = [UIColor colorWithRed:0 green:88/255.0 blue:245/255.0 alpha:1.0];
        day.textColor = [UIColor whiteColor];
        day.textAlignment = NSTextAlignmentCenter;
        day.text = @"天";
        day.font = [UIFont boldSystemFontOfSize:14];
        
        UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(bgView.bounds.size.width - 3 * bgView.bounds.size.height, 0, bgView.bounds.size.height * 2, bgView.bounds.size.height)];
        days.backgroundColor = [UIColor colorWithRed:70/255.0 green:165/255.0 blue:245/255.0 alpha:1.0];
        days.textColor = [UIColor whiteColor];
        days.textAlignment = NSTextAlignmentCenter;
        days.text = d;
        days.font = [UIFont systemFontOfSize:20];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, bgView.bounds.size.width - 5 - 3 * bgView.bounds.size.height, bgView.bounds.size.height)];
        name.text = n;
        name.font = [UIFont boldSystemFontOfSize:14];
        
        
        [bgView addSubview:day];
        [bgView addSubview:days];
        [bgView addSubview:name];
        [self addSubview:bgView];
    }
    return self;
}

@end
