//
//  ProfileViewController.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/12.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

enum CellTypeIndex: Int, CaseIterable {
    case profile
    case slack
    case watch
    case version
}

final class ProfileViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpTableView()
    }

    fileprivate func setUpUI() {
        self.navigationItem.title = "PROFILE"
    }

    fileprivate func setUpTableView() {
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.tableFooterView = UIView(frame: .zero)
        let profileCellNib = UINib(nibName: "UserInfoTableViewCell", bundle: nil)
        self.profileTableView.register(profileCellNib, forCellReuseIdentifier: "ProfileCell")
        let singleTextCellNib = UINib(nibName: "SingleTextTableViewCell", bundle: nil)
        self.profileTableView.register(singleTextCellNib, forCellReuseIdentifier: "SingleTextCell")
        let doubleTextCellNib = UINib(nibName: "DoubleTextTableViewCell", bundle: nil)
        self.profileTableView.register(doubleTextCellNib, forCellReuseIdentifier: "DoubleTextCell")
    }
}

extension ProfileViewController: UITableViewDelegate {

}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellTypeIndex.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case CellTypeIndex.profile.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! UserInfoTableViewCell
            return cell
        case CellTypeIndex.slack.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTextCell", for: indexPath) as! SingleTextTableViewCell
            cell.cellTextLabel.text = "Slack Settings"
            return cell
        case CellTypeIndex.watch.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleTextCell", for: indexPath) as! SingleTextTableViewCell
            cell.cellTextLabel.text = "Share data with  Watch"
            return cell
        case CellTypeIndex.version.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleTextCell", for: indexPath) as! DoubleTextTableViewCell
            cell.cellTextLabel.text = "Version"
            let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
            cell.cellSubTextLabel.text = version ?? ""
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
