//
//  DetailViewController.m
//  TimeMaster
//
//  Created by GX on 15/2/12.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "DetailViewController.h"
#import "MatterCoreData.h"
#import "AddMatterViewController.h"




@interface DetailViewController ()

@property (strong,nonatomic) IBOutlet UILabel *daysLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong,nonatomic) MatterModel *matter;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _deleteButton.layer.cornerRadius = _deleteButton.bounds.size.height / 2;
    _bgView.layer.cornerRadius = 5;
    _matter = [_delegate getCorrentMatter];
    _daysLabel.text = [_matter getDays];
    _nameLabel.text = [NSString stringWithFormat:@"  距离%@还有",_matter.name];
    _dateLabel.text = [NSString stringWithFormat:@"目标日:%@",[_matter.date substringWithRange:NSMakeRange(0,10)]];
}
- (IBAction)modifyMatter:(id)sender {
    AddMatterViewController *addMatterViewController = [[AddMatterViewController alloc] init];
    [addMatterViewController setName:_matter.name AndDate:_matter.date];
    [self.navigationController pushViewController:addMatterViewController animated:YES];
}

- (IBAction)deleteMatter:(id)sender {
    [MatterCoreData deleteFromCoreData:_matter];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
