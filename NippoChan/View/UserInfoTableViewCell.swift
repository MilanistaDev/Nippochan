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
    let imageCache = ImageCache.sharedInstance

    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width / 2
        self.userImageView.layer.masksToBounds = true
        self.selectionStyle = .none
        let userDefaults = UserDefaults.standard
        let name = userDefaults.object(forKey: "ProfileName") as? String
        self.userNameLabel.text = name ?? "Your Name"
        let company = userDefaults.object(forKey: "ProfileCompany") as? String
        self.userCampanyLabel.text = company ?? "Your Company"
        if let memberId = userDefaults.object(forKey: "ProfileMemberId") as? String {
            self.userIdLabel.text = "Member ID: " + memberId
        } else { self.userIdLabel.text = "Member ID: XXX"}
        if let imageUrl = userDefaults.object(forKey: "ProfileImageUrl") as? String {
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
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
