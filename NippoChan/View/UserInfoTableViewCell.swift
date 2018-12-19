//
//  UserInfoTableViewCell.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/13.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var editGuideView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCampanyLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    let imageCache = ImageCache.sharedInstance

    override func awakeFromNib() {
        super.awakeFromNib()
        self.editGuideView.layer.cornerRadius = self.editGuideView.frame.height / 2
        self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2
        self.userImageView.layer.masksToBounds = true
        self.selectionStyle = .none
    }

    var userName: String? {
        didSet {
            if let userName = userName, userName.count != 0 {
                self.userNameLabel.text = userName
                self.editGuideView.isHidden = true
            } else {
                self.userNameLabel.text = "Your Name"
                self.editGuideView.isHidden = false
            }
        }
    }

    var userCompany: String? {
        didSet {
            if let userCompany = userCompany, userCompany.count != 0 {
                self.userCampanyLabel.text = userCompany
            } else {
                self.userCampanyLabel.text = "Your Company"
            }
        }
    }

    var userId: String? {
        didSet {
            if let userId = userId, userId.count != 0 {
                self.userIdLabel.text = "Member ID: " + userId
            } else {
                self.userIdLabel.text = "Member ID: XXX"
            }
        }
    }

    var imageUrl: String? {
        didSet {
            if let imageUrl = imageUrl, imageUrl.count != 0 {
                if let cachedImage = imageCache.object(forKey: NSString(string: imageUrl)) {
                    self.userImageView.image = cachedImage
                } else {
                    DispatchQueue.global(qos: .background).async {
                        do {
                            let imageData = try Data(contentsOf: URL(string: imageUrl)!)
                            DispatchQueue.main.async {
                                self.imageCache.setObject(UIImage(data: imageData)!,
                                                          forKey: NSString(string: imageUrl))
                                self.userImageView.image = UIImage(data: imageData)
                            }
                        } catch {
                            DispatchQueue.main.async {
                                self.userImageView.image = UIImage(named: "img_no_image")
                            }
                        }
                    }
                }
            } else {
                self.userImageView.image = UIImage(named: "img_no_image")
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
