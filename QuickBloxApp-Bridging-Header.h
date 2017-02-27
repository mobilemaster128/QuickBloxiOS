//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//


#ifndef quickbloxapp_bridging_Header_h
#define quickbloxapp_bridging_Header_h

@import UIKit;
@import Foundation;
@import SystemConfiguration;
@import MobileCoreServices;
@import SVProgressHUD;
@import Quickblox;

// Chat
@import MPGNotification;
@import QMChatViewController;
@import QMServices;
#import "QMMessageNotificationManager.h"
#import "UIImage+fixOrientation.h"
#import "SearchEmojiOnString/NSString+EMOEmoji.h"

//WebRTC
@import QuickbloxWebRTC;
#import "QBCore.h"
#import "Settings.h"

#endif
