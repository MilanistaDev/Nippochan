//
//  ProfileViewController.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/12.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }

    fileprivate func setUpUI() {
        self.navigationItem.title = "PROFILE"
    }
}
