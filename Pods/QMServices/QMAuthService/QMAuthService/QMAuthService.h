//
//  QMBaseAuthService.h
//  QMServices
//
//  Created by Andrey Ivanov on 29.10.14.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import "QMBaseService.h"

@protocol QMAuthServiceDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface QMAuthService : QMBaseService

/**
 *  Identifies user authorisation status.
 */
@property (assign, nonatomic, readonly) BOOL isAuthorized;

/**
 *  Add instance that confirms auth service multicaste protocol
 *
 *  @param delegate instance that confirms id<QMAuthServiceDelegate> protocol
 */
- (void)addDelegate:(id <QMAuthServiceDelegate>)delegate;

/**
 *  Remove instance that confirms auth service multicaste protocol
 *
 *  @param delegate instance that confirms id<QMAuthServiceDelegate> protocol
 */
- (void)removeDelegate:(id <QMAuthServiceDelegate>)delegate;

/**
 *  User sign up and login
 *
 *  @param user       QuickBlox User
 *  @param completion completion block
 *
 *  @return Cancelable request
 */
- (QBRequest *)signUpAndLoginWithUser:(QBUUser *)user completion:(nullable void(^)(QBResponse *response, QBUUser * _Nullable userProfile))completion;

/**
 *  User login
 *
 *  @param user       QuickBlox User
 *  @param completion completion block
 *
 *  @return Cancelable request
 */
- (QBRequest *)logInWithUser:(QBUUser *)user completion:(nullable void(^)(QBResponse *response, QBUUser * _Nullable userProfile))completion;

/**
 *  Login with twitter digits auth headers
 *
 *  @param authHeaders Taken from '-[DGTOAuthSigning OAuthEchoHeadersToVerifyCredentials]'
 *  @param completion  completion block with response and user profile
 *
 *  @return Cancelable request
 */
- (QBRequest *)loginWithTwitterDigitsAuthHeaders:(NSDictionary *)authHeaders completion:(nullable void(^)(QBResponse *response, QBUUser * _Nullable userProfile))completion;

/**
 *  Login with facebook
 *
 *  @param sessionToken Facebook session token
 *  @param completion   completion block
 *
 *  @return Cancelable request
 */
- (QBRequest *)logInWithFacebookSessionToken:(NSString *)sessionToken completion:(nullable void(^)(QBResponse *response, QBUUser * _Nullable userProfile))completion;


/**
 *  Login with twitter
 *
 *  @param accessToken       Twitter access token
 *  @param accessTokenSecret Twitter access token secret
 *  @param completion        completion block
 *
 *  @return Cancelable request
 */
- (QBRequest *)loginWithTwitterAccessToken:(NSString *)accessToken accessTokenSecret:(NSString *)accessTokenSecret completion:(nullable void(^)(QBResponse *response, QBUUser * _Nullable userProfile))completion;

/**
 *  Logout
 *
 *  @param completion completion block
 *
 *  @return Cancelable request
 */
- (QBRequest *)logOut:(nullable void(^)(QBResponse *response))completion;

@end

#pragma mark - Bolts

/**
 *  Bolts methods for QMAuthService
 */
@interface QMAuthService (Bolts)

/**
 *  Sign up user and login using Bolts.
 *
 *  @param user user instance to sign up and login
 *
 *  @return BFTask with QBUUser instance
 *
 *  @see In order to know how to work with BFTask's see documentation https://github.com/BoltsFramework/Bolts-iOS#bolts
 */
- (BFTask QB_GENERIC(QBUUser *) *)signUpAndLoginWithUser:(QBUUser *)user;

/**
 *  Login with user using Bolts.
 *
 *  @param user user instance to login
 *
 *  @return BFTask with QBUUser instance
 *
 *  @see In order to know how to work with BFTask's see documentation https://github.com/BoltsFramework/Bolts-iOS#bolts
 */
- (BFTask QB_GENERIC(QBUUser *) *)loginWithUser:(QBUUser *)user;

/**
 *  Login with twitter digits using Bolts.
 *
 *  @param authHeaders Taken from '-[DGTOAuthSigning OAuthEchoHeadersToVerifyCredentials]'
 *
 *  @return BFTask with QBUUser instance
 *
 *  @see In order to know how to work with BFTask's see documentation https://github.com/BoltsFramework/Bolts-iOS#bolts
 */
- (BFTask QB_GENERIC(QBUUser *) *)loginWithTwitterDigitsAuthHeaders:(NSDictionary *)authHeaders;

/**
 *  Login with facebook session token using Bolts.
 *
 *  @param sessionToken valid facebook token with Email access
 *
 *  @return BFTask with QBUUser instance
 *
 *  @see In order to know how to work with BFTask's see documentation https://github.com/BoltsFramework/Bolts-iOS#bolts
 */
- (BFTask QB_GENERIC(QBUUser *) *)loginWithFacebookSessionToken:(NSString *)sessionToken;

/**
 *  Login with twitter using Bolts.
 *
 *  @param accessToken       twitter access token
 *  @param accessTokenSecret twitter access token secret
 *
 *  @see In order to know how to work with BFTask's see documentation https://github.com/BoltsFramework/Bolts-iOS#bolts
 */
- (BFTask QB_GENERIC(QBUUser *) *)loginWithTwitterAccessToken:(NSString *)accessToken accessTokenSecret:(NSString *)accessTokenSecret;

/**
 *  Logout current user using Bolts.
 *
 *  @return BFTask with failure error
 *
 *  @see In order to know how to work with BFTask's see documentation https://github.com/BoltsFramework/Bolts-iOS#bolts
 */
- (BFTask *)logout;

@end

@protocol QMAuthServiceDelegate <NSObject>
@optional

/**
 *  It called when auth service did log out
 *
 *  @param authService QMAuthService instance
 */
- (void)authServiceDidLogOut:(QMAuthService *)authService;

/**
 *  It called when auth service did log in with user
 *
 *  @param authService QMAuthService instance
 *  @param user logined QBUUser
 */
- (void)authService:(QMAuthService *)authService didLoginWithUser:(QBUUser *)user;

@end

NS_ASSUME_NONNULL_END
