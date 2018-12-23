//
//  StoreDataManager.swift
//  NippochanWatch Extension
//
//  Created by 麻生 拓弥 on 2018/12/23.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import Foundation

class StoreDataManager {

    class func storeData(receivedData: [String: Any]) {
        let userDefaults = UserDefaults.standard
        // 必須情報
        let webhookUrl = receivedData["webhookUrl"] as! String
        userDefaults.set(webhookUrl, forKey: UserDefaultsKey.Slack.webhookUrl)
        let authorName = receivedData["authorName"] as! String
        userDefaults.set(authorName, forKey: UserDefaultsKey.Profile.name)
        let wordsArray = receivedData["wordsArray"] as! [String]
        userDefaults.set(wordsArray, forKey: UserDefaultsKey.postWordsArray)

        // オプショナル
        let color = receivedData["color"] as! String
        userDefaults.set(color, forKey: UserDefaultsKey.Slack.favoriteColor)
        let authorLink = receivedData["authorLink"] as! String
        userDefaults.set(authorLink, forKey: UserDefaultsKey.Slack.authorLink)
        let authorIcon = receivedData["authorIcon"] as! String
        userDefaults.set(authorIcon, forKey: UserDefaultsKey.Profile.imageUrl)
    }
}
