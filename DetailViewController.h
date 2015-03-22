//
//  DetailViewController.h
//  TimeMaster
//
//  Created by GX on 15/2/12.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatterModel.h"

@protocol DetailViewDelegate <NSObject>

- (MatterModel *)getCorrentMatter;


@end

@interface DetailViewController : UIViewController

@property (nonatomic, assign) id<DetailViewDelegate> delegate;

@end
