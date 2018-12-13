//
//  UserInfoTableViewCell.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/13.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCampanyLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width / 2
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
