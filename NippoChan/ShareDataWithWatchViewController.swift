//
//  ShareDataWithWatchViewController.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/17.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit
import WatchConnectivity

final class ShareDataWithWatchViewController: UIViewController {

    @IBOutlet weak var addWordView: UIView!
    @IBOutlet weak var addWordTextField: UITextField!
    @IBOutlet weak var wordListTableView: UITableView!
    @IBOutlet weak var shareDataButton: UIButton!

    var session = WCSession.default
    fileprivate var wordListArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpTableView()
        self.setUpWordList()
        self.setUpWCSession()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.displayViewWithAnimation(isHidden: true)
    }

    fileprivate func setUpUI() {
        self.shareDataButton.layer.cornerRadius = 5.0
        self.shareDataButton.layer.masksToBounds = true
        self.addWordTextField.delegate = self
        self.navigationItem.title = NaviTitle.shareData
        self.navigationItem.rightBarButtonItem = editButtonItem
    }

    fileprivate func setUpTableView() {
        self.wordListTableView.contentInset.bottom = 80.0
        self.wordListTableView.delegate = self
        self.wordListTableView.dataSource = self
    }

    private func setUpWordList() {
        let userDefaults = UserDefaults.standard
        if let wordList = userDefaults.array(forKey: UserDefaultsKey.postWordsArray) as? [String] {
            self.wordListArray = wordList
            self.wordListTableView.reloadData()
        }
    }

    private func setUpWCSession() {
        if WCSession.isSupported() {
            self.session = WCSession.default
            self.session.delegate = self    // 不要そうだがないとApple Watchと通信できない
            self.session.activate()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.wordListTableView.isEditing = editing
    }

    private func displayViewWithAnimation(isHidden: Bool) {
        UIView.animate(withDuration: 1.0) {
            self.addWordView.isHidden = isHidden
        }
    }

    @IBAction func addWordAction(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if let addWord = self.addWordTextField.text, !addWord.isEmpty {
            self.wordListArray.append(addWord)
            userDefaults.set(self.wordListArray, forKey: UserDefaultsKey.postWordsArray)
            self.wordListTableView.reloadData()
        }
        self.addWordTextField.text = nil
        self.displayViewWithAnimation(isHidden: true)
    }

    @IBAction func addNewWordAction(_ sender: Any) {
        self.displayViewWithAnimation(isHidden: false)
    }

    @IBAction func shareDataWithWatchAction(_ sender: Any) {
        // 必須の情報が登録されているか
        if !GenerateShareDataManager.checkDataStatus() {
            self.showAlertDialog(title: "Data Error",
                                 message: "Required data is not registered.\nPlease check the data of Name, Webhook URL and words you want to post.")
            return
        }
        // Apple Watch へ送るDictionary
        let dic = GenerateShareDataManager.generateShareDataDic()

        self.session.sendMessage(dic, replyHandler: { (replyDic) in
            self.showAlertDialog(title: replyDic["replyStatus"] as? String ?? "?",
                                 message: "Successfully sent necessary data to Apple Watch.")
        }) { (error: Error) in
            self.showAlertDialog(title: "Error", message: error.localizedDescription)
        }
    }

    private func showAlertDialog(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ShareDataWithWatchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel(frame: CGRect(x: 20.0, y: 5.0, width: 0.0, height: 0.0))
        sectionLabel.text = "Registered words"
        sectionLabel.font = UIFont.setThemeFont(size: 15.0)
        sectionLabel.textColor = UIColor.white
        sectionLabel.sizeToFit()
        let sectionView: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0,
                                                       width: self.view.frame.width,
                                                       height: sectionLabel.frame.size.height+5.0))
        sectionView.addSubview(sectionLabel)
        sectionView.backgroundColor = UIColor.setThemeColor(alpha: 0.8)
        return sectionView
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.wordListArray.remove(at: indexPath.row)
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.wordListArray, forKey: UserDefaultsKey.postWordsArray)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing { return .delete }
        return .none
    }
}

extension ShareDataWithWatchViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        cell.textLabel?.text = self.wordListArray[indexPath.row]
        return cell
    }
}

extension ShareDataWithWatchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Close Keyboard
        textField.resignFirstResponder()
        return true
    }
}

// 不要そうだがないとApple Watchと通信できない
extension ShareDataWithWatchViewController: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
    }

    func sessionDidDeactivate(_ session: WCSession) {
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
}
