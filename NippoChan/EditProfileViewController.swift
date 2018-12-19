//
//  EditProfileViewController.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/16.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

final class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var memberIdTextField: UITextField!
    @IBOutlet weak var imageUrlTextFiled: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NaviTitle.editProfile
        self.setProfileData()
        self.nameTextField.delegate = self
        self.companyTextField.delegate = self
        self.memberIdTextField.delegate = self
        self.imageUrlTextFiled.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.nameTextField.text, forKey: UserDefaultsKey.Profile.name)
        userDefaults.set(self.companyTextField.text, forKey: UserDefaultsKey.Profile.company)
        userDefaults.set(self.memberIdTextField.text, forKey: UserDefaultsKey.Profile.memId)
        userDefaults.set(self.imageUrlTextFiled.text, forKey: UserDefaultsKey.Profile.imageUrl)
    }

    private func setProfileData() {
        let userDefaults = UserDefaults.standard
        self.nameTextField.text = userDefaults.object(forKey: UserDefaultsKey.Profile.name) as? String ?? ""
        self.companyTextField.text = userDefaults.object(forKey: UserDefaultsKey.Profile.company) as? String ?? ""
        self.memberIdTextField.text = userDefaults.object(forKey: UserDefaultsKey.Profile.memId) as? String ?? ""
        self.imageUrlTextFiled.text = userDefaults.object(forKey: UserDefaultsKey.Profile.imageUrl) as? String ?? ""
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Close Keyboard
        textField.resignFirstResponder()
        return true
    }
}
