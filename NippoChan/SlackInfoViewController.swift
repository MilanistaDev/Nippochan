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
        userDefaults.set(self.webhookUrlTextField.text, forKey: "SlackWebhookUrl")
        userDefaults.set(self.authorLinkTextFeild.text, forKey: "SlackAuthorLink")
        userDefaults.set(self.favoriteColorTextField.text, forKey: "SlackFavoriteColor")
    }

    fileprivate func setUpUI() {
        self.navigationItem.title = "SLACK SETTINGS"
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
        let webhookUrl = userDefaults.object(forKey: "SlackWebhookUrl") as? String
        self.webhookUrlTextField.text = webhookUrl ?? ""
        let authorLink = userDefaults.object(forKey: "SlackAuthorLink") as? String
        self.authorLinkTextFeild.text = authorLink ?? ""
        let favoriteColor = userDefaults.object(forKey: "SlackFavoriteColor") as? String
        self.favoriteColorTextField.text = favoriteColor ?? ""
    }

    // MARK: - Button Action

    @IBAction func openWebhookInfoAction(_ sender: Any) {
        let webHookInfoUrl = URL(string: "https://yumemi.slack.com/apps/new/A0F7XDUAZ-incoming-webhooks")
        let safariVC = SFSafariViewController(url: webHookInfoUrl!)
        self.present(safariVC, animated: true, completion: nil)
    }

    @IBAction func bannerTapAction(_ sender: Any) {
        let storeUrl = URL(string: "https://itunes.apple.com/jp/app/color-convertor/id1203567143?mt=8")
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
