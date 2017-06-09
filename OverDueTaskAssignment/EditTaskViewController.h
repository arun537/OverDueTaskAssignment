//
//  EditTaskViewController.h
//  OverDueTaskAssignment
//
//  Created by Arun Singh Chauhan on 6/8/17.
//  Copyright © 2017 Arun Singh Chauhan. All rights reserved.
//
#import "TaskObject.h"

@protocol editTaskViewDelegate <NSObject>

@required
-(void)didSave:(TaskObject*)taskobject;

@end
#import "ViewController.h"

@interface EditTaskViewController : UIViewController 
@property (weak, nonatomic) id<editTaskViewDelegate> delegate;
@property (strong, nonatomic) TaskObject* taskObject;
@property (strong, nonatomic) IBOutlet UITextField *editTaskTextField;
@property (strong, nonatomic) IBOutlet UITextView *EditTaskTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *editTaskDatePicker;
- (IBAction)SaveButtonPressed:(UIBarButtonItem *)sender;

@end
