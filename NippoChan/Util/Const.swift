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
}

struct NaviTitle {
    static let profile = "PROFILE"
    static let editProfile = "EDIT PROFILE"
    static let slackSettings = "SLACK SETTINGS"
    static let shareData = "SHARE DATA"
}
