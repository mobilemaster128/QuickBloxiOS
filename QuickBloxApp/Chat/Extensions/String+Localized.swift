//
//  String+Localized.swift
//  QuickBloxApp
//
//  Created by Sierra on 2/25/17.
//  Copyright © 2017 Sierra. All rights reserved.
//
//

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
