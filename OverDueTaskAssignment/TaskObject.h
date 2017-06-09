//
//  TaskObject.h
//  OverDueTaskAssignment
//
//  Created by Arun Singh Chauhan on 6/8/17.
//  Copyright © 2017 Arun Singh Chauhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskObject : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* descript;
@property (strong, nonatomic) NSDate* date;
@property (nonatomic) BOOL completion;


@end
