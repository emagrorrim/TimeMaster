//
//  MatterCoreData.h
//  TimeMaster
//
//  Created by GX on 15/2/4.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatterModel.h"

@interface MatterCoreData : NSObject


+ (BOOL)addToCoreData:(MatterModel*)matter;
+ (BOOL)deleteFromCoreData:(MatterModel*)matter;
+ (MatterModel *)getTitleMatter;
+ (NSArray *)getAllMatter;

@end
