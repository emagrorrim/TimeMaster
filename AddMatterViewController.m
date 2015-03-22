//
//  AddMatterViewController.m
//  TimeMaster
//
//  Created by GX on 15/2/4.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "AddMatterViewController.h"
#import "MatterCoreData.h"

@interface AddMatterViewController()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIView *buttonBgView;

@end

@implementation AddMatterViewController

- (void)viewDidLoad
{
    _nameTextField.delegate = self;
    _buttonBgView.layer.cornerRadius = _buttonBgView.bounds.size.height / 6;
    //_buttonBgView.alpha = 0.6;
    [super viewDidLoad];
}


- (IBAction)addNewMatter:(id)sender
{
    NSString *date = [NSString stringWithFormat:@"%@",_datePicker.date];
    _dateTextField.text = [date substringWithRange:NSMakeRange(0,10)];
    if (![_nameTextField.text isEqualToString:@""] && ![_dateTextField.text isEqualToString:@""]) {
        MatterModel *matter = [[MatterModel alloc] initWithName:_nameTextField.text andDate:[NSString stringWithFormat:@"%@ 00:00:00",_dateTextField.text]];
        [MatterCoreData addToCoreData:matter];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NSLog(@"不能为空！");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_nameTextField resignFirstResponder];
    return YES;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setName:(NSString *)n AndDate:(NSString *)d {
    _nameTextField.text = n;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[format dateFromString:d];
    _datePicker.date = date;
}

@end
