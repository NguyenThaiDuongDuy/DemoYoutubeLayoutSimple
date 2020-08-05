//
//  Video.swift
//  demoLayout
//
//  Created by DuyNTD1 on 7/13/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import Foundation

class Video: Decodable {
    var title : String?
    var number_of_views : Int?
    var thumbnail_image_name : String?
    var channel: channel?
    var duration :Int?
    
}

class channel: Decodable {
    var name : String?
    var profile_image_name :String?
}

class SettingData:NSObject {
    var nameIcon:String? = ""
    var nameLabel:NameSetting?
    
    init(NameIcon: String?, NameLabel: NameSetting?) {
        nameIcon = NameIcon
        nameLabel = NameLabel
    }
    
    enum NameSetting:String {
        case Setting = "Setting"
        case Privacy = "Privacy"
        case FeedBack = "FeedBack"
        case Account = "Account"
        case Help = "Help"
        case Cancel = "Cancel"
    }
}

