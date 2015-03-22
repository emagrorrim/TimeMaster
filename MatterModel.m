//
//  MatterModel.m
//  TimeMaster
//
//  Created by GX on 15/2/4.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "MatterModel.h"

@implementation MatterModel

- (instancetype)initWithName:(NSString *)n andDate:(NSString *)d{
    self = [super init];
    if (self) {
        _name = n;
        _date = d;
        _title = NO;
    }
    return self;
}

- (NSString *)getDays {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate *senddate=[NSDate date];
    
    NSDate *endDate = [dateFormatter dateFromString:_date];
    NSString *sendDate = [dateFormatter stringFromDate:[NSDate date]];
    sendDate = [sendDate substringWithRange:NSMakeRange(0,10)];
    sendDate = [NSString stringWithFormat:@"%@ 00:00:00",sendDate];
    
    
    NSDate *senderDate = [dateFormatter dateFromString:sendDate];
    //NSLog(@"\n%@\n%@",sendDate,_date);
    
    NSTimeInterval time=[endDate timeIntervalSinceDate:senderDate];
    NSInteger days = time / (3600 * 24);
    //days++;
    if (days <= 0) days = 0;
    //else days++;
    //NSLog(@"%ld",(long)days);
    NSString *d = [NSString stringWithFormat:@"%ld",(long)days];
    return d;
}

@end
