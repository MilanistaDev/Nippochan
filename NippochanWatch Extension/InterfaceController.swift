//
//  InterfaceController.swift
//  NippochanWatch Extension
//
//  Created by 麻生 拓弥 on 2018/12/12.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var wordsPicker: WKInterfacePicker!
    @IBOutlet weak var sendButton: WKInterfaceButton!

    var session = WCSession.default
    var pickerArray: [WKPickerItem] = []
    var selectedWord: String?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.setUpWCSession()
        let userDefaults = UserDefaults.standard
        if let wordsArray = userDefaults.object(forKey: UserDefaultsKey.postWordsArray) as? [String] {
            self.generatePickerData(wordsArray: wordsArray)
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    private func setUpWCSession() {
        if WCSession.isSupported() {
            self.session = WCSession.default
            self.session.delegate = self
            self.session.activate()
        }
    }

    private func generatePickerData(wordsArray: [String]) {
        for word in wordsArray {
            let pickerItem = WKPickerItem()
            pickerItem.title = word
            self.pickerArray.append(pickerItem)
        }
        self.wordsPicker.setItems(self.pickerArray)
    }

    @IBAction func selectWordAction(_ value: Int) {
        self.sendButton.setEnabled(true)
        self.selectedWord = self.pickerArray[value].title
        self.sendButton.setTitle(self.selectedWord)
    }

    @IBAction func sendAction() {
        self.sendButton.setTitle("Send")
        self.sendButton.setEnabled(false)
    }
}

extension InterfaceController: WCSessionDelegate {

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        // Apple Storeの不揮発領域にデータを保存
        StoreDataManager.storeData(receivedData: message)
        // ピッカーのデータを生成
        let wordsArray: [String] = message["wordsArray"] as! [String]
        self.generatePickerData(wordsArray: wordsArray)
        // iPhoneに返却
        replyHandler(["replyStatus": "Success"])
    }
}
