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

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.setUpWCSession()
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
        self.sendButton.setTitle(self.pickerArray[value].title)
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
        let wordsArray: [String] = message["wordsArray"] as! [String]
        self.generatePickerData(wordsArray: wordsArray)
        let replyDic = ["replyStatus": "Success"]
        replyHandler(replyDic)
    }
}
