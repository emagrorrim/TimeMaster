//
//  ViewController.m
//  TimeMaster
//
//  Created by GX on 15/2/1.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "ViewController.h"
#import "MatterCoreData.h"
#import "matterCell.h"
#import "DetailViewController.h"


#define gapWidth 5

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,DetailViewDelegate>
@property (nonatomic) NSInteger viewWidth;
@property (nonatomic) NSInteger viewHeight;
@property (strong,nonatomic) IBOutlet UIView *bgView;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIView *titleView;
@property (strong,nonatomic) NSArray *modelArray;
@property (strong,nonatomic) MatterModel *currentMatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _modelArray = [[NSArray alloc] init];
    _modelArray = [MatterCoreData getAllMatter];
    _viewHeight = self.view.bounds.size.height;
    _viewWidth = self.view.bounds.size.width;
    //NSLog(@"%ld,%ld",(long)_viewHeight,(long)_viewWidth);
    _bgView.layer.cornerRadius = _viewWidth / 32;
    [self titleViewInit];
    [self tableViewInit];
    [self ExtendInit];
}

- (void)ExtendInit {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)applicationWillResignActive {
    [self saveDefaults];
//    if ([MatterCoreData getTitleMatter] != nil) {
//        [self saveDefaults];
//    } else {
//        [self clearDefault];
//    }
}

- (void)saveDefaults {
    MatterModel *matter = [[MatterModel alloc] init];
    matter = [MatterCoreData getTitleMatter];
//    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.TimeMaster"];
//    [userDefault setObject:matter.name forKey:@"name"];
//    [userDefault setObject:[matter getDays] forKey:@"days"];
//    [userDefault synchronize];
    //NSLog(@"%@",[userDefault objectForKey:@"name"]);
}

- (void)clearDefault {
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.TimeMaster"];
    [userDefault removeObjectForKey:@"name"];
    [userDefault removeObjectForKey:@"days"];
    [userDefault synchronize];
}

- (void)reloadArray {
    _modelArray = nil;
    _modelArray = [[NSArray alloc] init];
    _modelArray = [MatterCoreData getAllMatter];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadArray];
    [self titleViewInit];
    [_tableView reloadData];
}

- (void)titleViewInit
{
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, _viewWidth - 2 * gapWidth, _viewHeight / 6)];
    _titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, _viewHeight / 12 - 15, 2 * _viewWidth / 3 - 30, 20)];
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(20, _viewHeight / 12, 2 * _viewWidth / 3 - 30, 20)];
    UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(2 * _viewWidth / 3 - 15, _viewHeight / 12 -30, 50, 60)];
    title.font = [UIFont boldSystemFontOfSize:13];
    detail.font = [UIFont systemFontOfSize:11];
    detail.textColor = [UIColor lightGrayColor];
    days.font = [UIFont boldSystemFontOfSize:60];
    days.textAlignment = NSTextAlignmentRight;
    UILabel *dayTag = [[UILabel alloc] initWithFrame:CGRectMake(2 * _viewWidth / 3 + 35, _viewHeight / 12 - 20, 25, 12)];
    dayTag.text = @"days";
    dayTag.font = [UIFont systemFontOfSize:10];
    dayTag.textColor = [UIColor whiteColor];
    dayTag.backgroundColor = [UIColor redColor];
    dayTag.textAlignment = NSTextAlignmentCenter;
    dayTag.layer.cornerRadius = dayTag.bounds.size.height / 3;
    dayTag.clipsToBounds = YES;
    
    MatterModel *matter = [MatterCoreData getTitleMatter];
    if (matter) {
        title.text = [NSString stringWithFormat:@"距离%@还有",matter.name];
        detail.text = [NSString stringWithFormat:@"目标日:%@",[matter.date substringWithRange:NSMakeRange(0,10)]];//[a substringWithRange:NSMakeRange(4,2)]
        days.text = [matter getDays];
        days.adjustsFontSizeToFitWidth = YES;
        
        
        [_titleView addSubview:title];
        [_titleView addSubview:detail];
        [_titleView addSubview:days];
        [_titleView addSubview:dayTag];
    } else {
        title.text = @"未创建事件";
        [_titleView addSubview:title];
    }
    [self.bgView addSubview:_titleView];
}

- (void)tableViewInit
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64 + _titleView.bounds.size.height + gapWidth, _viewWidth - 2 * gapWidth, _viewHeight - (64 + gapWidth + _titleView.bounds.size.height) - gapWidth)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = nil;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.bgView addSubview:_tableView];
}

#pragma mark - UItableView Delegate and DataSourse


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_modelArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MatterModel *matter = [_modelArray objectAtIndex:([_modelArray count] - 1 - indexPath.row)];
    matterCell *cell = [[matterCell alloc] initWithName:matter.name AndDate:[matter getDays] AndViewWidth:_viewWidth];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _currentMatter = [_modelArray objectAtIndex:([_modelArray count] - 1 - indexPath.row)];
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.delegate = self;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (MatterModel*)getCorrentMatter {
    return _currentMatter;
}

@end
