//
//  QBCOCustomObject
//  Quickblox
//
//  Created by QuickBlox team on 8/14/12.
//  Copyright (c) 2016 QuickBlox. All rights reserved.
//

#import <Quickblox/QBNullability.h>
#import <Quickblox/QBGeneric.h>

@class QBCOPermissions;

NS_ASSUME_NONNULL_BEGIN

/** 
 *  QBCOCustomObject class interface.
 *  This class represents QuickBlox custom object model.
 *
 *  @see http://quickblox.com/developers/Custom_Objects#Module_description
 */
@interface QBCOCustomObject : NSObject <NSCoding, NSCopying>

/** 
 *  Object ID.
 */
@property (nonatomic, copy, nullable) NSString *ID;

/** 
 *  Relations: parent object's ID.
 */
@property (nonatomic, copy, nullable) NSString *parentID;

/** 
 *  Date & time when record was created, filled automatically.
 */
@property (nonatomic, strong, nullable) NSDate *createdAt;

/** 
 *  Date & time when record was updated, filled automatically.
 */
@property (nonatomic, strong, nullable) NSDate *updatedAt;

/** 
 *  Class name.
 */
@property (nonatomic, copy, nullable) NSString *className;

/** 
 *  User's ID, which created current record.
 */
@property (nonatomic, assign) NSUInteger userID;

/** 
 *  Custom object's fields.
 */
@property (nonatomic, strong, null_resettable) NSMutableDictionary <NSString *, id> *fields;

/** 
 *  Object permissions.
 */
@property (nonatomic, strong, nullable) QBCOPermissions *permissions;

/** 
 *  Create new custom object.
 *
 *  @return New instance of QBCustomObject.
 */
+ (instancetype)customObject;

@end

NS_ASSUME_NONNULL_END
