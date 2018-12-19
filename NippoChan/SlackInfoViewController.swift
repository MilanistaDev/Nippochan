//
//  SlackInfoViewController.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/17.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit
import SafariServices

final class SlackInfoViewController: UIViewController {

    @IBOutlet weak var webhookUrlTextField: UITextField!
    @IBOutlet weak var authorLinkTextFeild: UITextField!
    @IBOutlet weak var favoriteColorTextField: UITextField!

    @IBOutlet weak var bannerIconImageView: UIImageView!
    @IBOutlet weak var bannerDlBaseView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.webhookUrlTextField.text, forKey: UserDefaultsKey.Slack.webhookUrl)
        userDefaults.set(self.authorLinkTextFeild.text, forKey: UserDefaultsKey.Slack.authorLink)
        userDefaults.set(self.favoriteColorTextField.text, forKey: UserDefaultsKey.Slack.favoriteColor)
    }

    fileprivate func setUpUI() {
        self.navigationItem.title = NaviTitle.slackSettings
        self.bannerIconImageView.layer.cornerRadius = 10.0
        self.bannerIconImageView.layer.masksToBounds = true
        self.bannerDlBaseView.layer.cornerRadius = 12.0
        self.setSlackInfoData()
        self.webhookUrlTextField.delegate = self
        self.authorLinkTextFeild.delegate = self
        self.favoriteColorTextField.delegate = self
    }

    private func setSlackInfoData() {
        let userDefaults = UserDefaults.standard
        self.webhookUrlTextField.text = userDefaults.object(forKey: UserDefaultsKey.Slack.webhookUrl) as? String ?? ""
        self.authorLinkTextFeild.text = userDefaults.object(forKey: UserDefaultsKey.Slack.authorLink) as? String ?? ""
        self.favoriteColorTextField.text = userDefaults.object(forKey: UserDefaultsKey.Slack.favoriteColor) as? String ?? ""
    }

    // MARK: - Button Action

    @IBAction func openWebhookInfoAction(_ sender: Any) {
        let webHookInfoUrl = URL(string: URLLink.slackWebhook)
        let safariVC = SFSafariViewController(url: webHookInfoUrl!)
        self.present(safariVC, animated: true, completion: nil)
    }

    @IBAction func bannerTapAction(_ sender: Any) {
        let storeUrl = URL(string: URLLink.colorConv)
        let safariVC = SFSafariViewController(url: storeUrl!)
        self.present(safariVC, animated: true, completion: nil)
    }
}

extension SlackInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Close Keyboard
        textField.resignFirstResponder()
        return true
    }
}
