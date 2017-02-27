//
//  QMMessageNotification.h
//  QuickBloxApp
//
//  Created by Sierra on 2/25/17.
//  Copyright © 2017 Sierra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPGNotification.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  QMMessageNotification class interface.
 *  Used as MPGNotification manager for message displaying.
 */
@interface QMMessageNotification : NSObject

@property (nonatomic, assign, getter = isOneByOneMode) BOOL oneByOneMode;

- (void)showNotificationWithTitle:(NSString*)title
                         subtitle:(NSString*)subtitle
                            color:(UIColor*)color
                        iconImage:(UIImage*)iconImage;

@end

NS_ASSUME_NONNULL_END
