//
//  MatterModel.h
//  TimeMaster
//
//  Created by GX on 15/2/4.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MatterModel : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *date;
@property (nonatomic) BOOL title;

- (NSString *)getDays;
- (instancetype)initWithName:(NSString *)n andDate:(NSString *)d;

@end
