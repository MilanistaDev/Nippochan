//
//  PostWordsManager.swift
//  NippochanWatch Extension
//
//  Created by 麻生 拓弥 on 2018/12/23.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import Foundation

class PostWordsManager {
    class func postWords(word: String) {
        let userDefaults = UserDefaults.standard
        let webhookUrl = userDefaults.object(forKey: UserDefaultsKey.Slack.webhookUrl) as! String
        let authorName = userDefaults.object(forKey: UserDefaultsKey.Profile.name) as! String
        let color = userDefaults.object(forKey: UserDefaultsKey.Slack.favoriteColor) as! String
        let authorLink = userDefaults.object(forKey: UserDefaultsKey.Slack.authorLink) as! String
        let authorIcon = userDefaults.object(forKey: UserDefaultsKey.Profile.imageUrl) as! String

        var request = URLRequest(url: URL(string: webhookUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let params: [String: Any] = [
            "attachments": [
                "color": color,
                "author_name": authorName,
                "author_link": authorLink,
                "author_icon": authorIcon,
                "text": word,
                "footer": "via 日報ちゃん",
                "footer_icon": URLLink.appIcon
            ]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            NotificationCenter.default.post(name: Notification.Name("sentFailed"), object: nil)
            //print(error.localizedDescription)
        }

        let task = URLSession.shared.dataTask(with: request)
        { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                NotificationCenter.default.post(name: Notification.Name("sentFailed"), object: nil)
                 //print(error.localizedDescription)
                return
            }
            guard let _ = data, let response = response as? HTTPURLResponse else {
                NotificationCenter.default.post(name: Notification.Name("sentFailed"), object: nil)
                 //print("No data or No response")
                return
            }

            if response.statusCode == 200 {
                NotificationCenter.default.post(name: Notification.Name("sentSuccess"), object: nil)
                // print(data)
            } else {
                NotificationCenter.default.post(name: Notification.Name("sentFailed"), object: nil)
                 //print(response.statusCode)
            }
        }
        task.resume()
    }
}
