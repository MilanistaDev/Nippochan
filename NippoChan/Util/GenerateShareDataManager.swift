//
//  GenerateShareDataManager.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/21.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import Foundation

class GenerateShareDataManager {

    class func checkDataStatus() -> Bool {
        let userDefaults = UserDefaults.standard
        if let _ = userDefaults.object(forKey: UserDefaultsKey.Slack.webhookUrl) as? String,
           let _ = userDefaults.object(forKey: UserDefaultsKey.Profile.name) as? String,
           let _ = userDefaults.object(forKey: UserDefaultsKey.postWordsArray) as? [String] {
            return true
        }
        return false
    }

    class func generateShareDataDic() -> [String: Any] {
        var shareDataDic: [String: Any] = [:]
        let userDefaults = UserDefaults.standard
        // 必須情報
        shareDataDic["webhookUrl"] = userDefaults.object(forKey: UserDefaultsKey.Slack.webhookUrl) as! String
        shareDataDic["authorName"] = userDefaults.object(forKey: UserDefaultsKey.Profile.name) as! String
        shareDataDic["wordsArray"] = userDefaults.array(forKey: UserDefaultsKey.postWordsArray) as! [String]
        // オプショナル
        if let color = userDefaults.object(forKey: UserDefaultsKey.Slack.favoriteColor) as? String , !color.isEmpty {
            shareDataDic["color"] = color
        } else { shareDataDic["color"] = "#009944" }
        if let authorLink = userDefaults.object(forKey: UserDefaultsKey.Slack.authorLink) as? String, !authorLink.isEmpty {
            shareDataDic["authorLink"] = authorLink
        } else { shareDataDic["authorLink"] = "" }
        if let authorIcon = userDefaults.object(forKey: UserDefaultsKey.Profile.imageUrl) as? String, !authorIcon.isEmpty {
            shareDataDic["authorIcon"] = authorIcon
        } else { shareDataDic["authorIcon"] = "" }

        return shareDataDic
    }
}
