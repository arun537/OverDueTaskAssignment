//
//  AddTaskViewController.h
//  OverDueTaskAssignment
//
//  Created by Arun Singh Chauhan on 6/8/17.
//  Copyright © 2017 Arun Singh Chauhan. All rights reserved.
//

#import "TaskObject.h"


@protocol AddTaskViewControllerDelegate <NSObject>
-(void)didCancel;
-(void)didAddTask:(TaskObject*)task;
@end

#import "ViewController.h"
#import "DeatilTaskViewController.h"

@interface AddTaskViewController : UIViewController 
@property (weak, nonatomic) id<AddTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *TaskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *TaskDatePicker;
- (IBAction)CancelButtonPressed:(UIButton *)sender;
- (IBAction)AddTaskButtonPressed:(UIButton *)sender;

@end
