//
//  QBContactListItem.h
//  Quickblox
//
//  Created by QuickBlox team on 3/18/13.
//  Copyright (c) 2016 QuickBlox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Quickblox/QBNullability.h>
#import <Quickblox/QBGeneric.h>
#import "ChatEnums.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kPresenceSubscriptionStateNone;
extern NSString * const kPresenceSubscriptionStateTo;
extern NSString * const kPresenceSubscriptionStateFrom;
extern NSString * const kPresenceSubscriptionStateBoth;

/**
 *  QBContactListItem class interface.
 *  Represents user's contact list item.
 */
@interface QBContactListItem : NSObject

/**
 *  Unique identifier of user.
 */
@property (nonatomic, assign) NSUInteger userID;

/**
 *  User status (online/offline).
 */
@property (nonatomic, assign, getter=isOnline) BOOL online;

/**
 *  User subscription state. Read more about states http://xmpp.org/rfcs/rfc3921.html#roster
 */
@property (nonatomic, assign) QBPresenseSubscriptionState subscriptionState;

// Helpers: translate subscriptionState to and from string to and from enum
+ (QBPresenseSubscriptionState)subscriptionStateFromString:(nullable NSString *)subscriptionState;
+ (nullable NSString *)subscriptionStateToString:(QBPresenseSubscriptionState)subscriptionState;

@end

NS_ASSUME_NONNULL_END
