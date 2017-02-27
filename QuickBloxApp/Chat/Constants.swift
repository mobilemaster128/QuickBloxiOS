//
//  Constants.swift
//  QuickBloxApp
//
//  Created by Sierra on 2/25/17.
//  Copyright © 2017 Sierra. All rights reserved.
//

import Foundation

let kChatPresenceTimeInterval:TimeInterval = 45
let kDialogsPageLimit:UInt = 100
let kMessageContainerWidthPadding:CGFloat = 40.0


/*  ServicesManager
	...
	func downloadLatestUsers(successBlock:(([QBUUser]?) -> Void)?, errorBlock:((NSError) -> Void)?) {
	
	let enviroment = Constants.QB_USERS_ENVIROMENT
	
	self.usersService.searchUsersWithTags([enviroment])
	*/
class Constants {
    
    class var QB_USERS_ENVIROMENT: String {
        
        #if DEBUG
            return "iostest"
        #elseif QA
            return "iostest"
        #else
            assert(false, "Not supported build configuration")
            return ""
        #endif
        
    }
}
