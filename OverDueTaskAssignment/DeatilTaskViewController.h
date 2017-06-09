//
//  DeatilTaskViewController.h
//  OverDueTaskAssignment
//
//  Created by Arun Singh Chauhan on 6/8/17.
//  Copyright © 2017 Arun Singh Chauhan. All rights reserved.
//


#import "TaskObject.h"

@protocol detailTaskViewControllerDelegate <NSObject>
@required
-(void)didSaveFromDetail:(TaskObject*)taskObject;

@end
#import "ViewController.h"
#import "EditTaskViewController.h"

@interface DeatilTaskViewController : UIViewController <editTaskViewDelegate>
@property (weak, nonatomic) id<detailTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) TaskObject* taskobject;
@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *TaskDiscriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDatelabel;
- (IBAction)EditButtonPressed:(UIBarButtonItem *)sender;

@end
