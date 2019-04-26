//
//  Const.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/19.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import Foundation

struct UserDefaultsKey {
    struct Profile {
        static let name = "ProfileName"
        static let company = "ProfileCompany"
        static let memId = "ProfileMemberId"
        static let imageUrl = "ProfileImageUrl"
    }
    struct Slack {
        static let webhookUrl = "SlackWebhookUrl"
        static let authorLink = "SlackAuthorLink"
        static let favoriteColor = "SlackFavoriteColor"
    }
    static let postWordsArray = "PostWordsArray"
}

struct URLLink {
    static let slackWebhook = "https://slack.com/services/new/incoming-webhook"
    static let colorConv = "https://itunes.apple.com/jp/app/color-convertor/id1203567143?mt=8"
    static let appIcon = "https://4.bp.blogspot.com/-zMlYavqwYrw/XBs5sPGYkFI/AAAAAAAAFec/kNM7EQVj_nY85wWezdwVDBRcE_823a5DwCLcBGAs/s1600/app_icon_60%25403x.png"
    static let watchKitIcon = "http://devmonologue.com/images/2014/11/watchkit_2x.png"
}

struct NaviTitle {
    static let profile = "PROFILE"
    static let editProfile = "EDIT PROFILE"
    static let slackSettings = "SLACK SETTINGS"
    static let shareData = "SHARE DATA"
}
