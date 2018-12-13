//
//  SingleTextTableViewCell.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/13.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

class SingleTextTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
