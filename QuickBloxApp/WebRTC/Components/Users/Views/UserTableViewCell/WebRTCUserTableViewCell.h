//
//  UserTableViewCell.h
//  LoginComponent
//
//  Created by Andrey Ivanov on 03/06/16.
//  Copyright © 2016 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebRTCUserTableViewCell : UITableViewCell

- (void)setFullName:(NSString *)fullName;
- (void)setCheck:(BOOL)isCheck;
- (void)setUserImage:(UIImage *)image;

@end
