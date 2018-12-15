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
        self.navigationItem.title = "EDIT PROFILE"
        self.setProfileData()
        self.nameTextField.delegate = self
        self.companyTextField.delegate = self
        self.memberIdTextField.delegate = self
        self.imageUrlTextFiled.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.nameTextField.text, forKey: "ProfileName")
        userDefaults.set(self.companyTextField.text, forKey: "ProfileCompany")
        userDefaults.set(self.memberIdTextField.text, forKey: "ProfileMemberId")
        userDefaults.set(self.imageUrlTextFiled.text, forKey: "ProfileImageUrl")
    }

    private func setProfileData() {
        let userDefaults = UserDefaults.standard
        let name = userDefaults.object(forKey: "ProfileName") as? String
        self.nameTextField.text = name ?? ""
        let company = userDefaults.object(forKey: "ProfileCompany") as? String
        self.companyTextField.text = company ?? ""
        let memberId = userDefaults.object(forKey: "ProfileMemberId") as? String
        self.memberIdTextField.text = memberId ?? ""
        let imageUrl = userDefaults.object(forKey: "ProfileImageUrl") as? String
        self.imageUrlTextFiled.text = imageUrl ?? ""
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Close Keyboard
        textField.resignFirstResponder()
        return true
    }
}
