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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.profileTableView.reloadData()
    }

    fileprivate func setUpUI() {
        self.navigationItem.title = NaviTitle.profile
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case CellTypeIndex.profile.rawValue:
            let storyBoard = UIStoryboard(name: "EditProfile", bundle: nil)
            let editProfileVC = storyBoard.instantiateInitialViewController()
            self.navigationController?.pushViewController(editProfileVC!, animated: true)
        case CellTypeIndex.slack.rawValue:
            let storyBoard = UIStoryboard(name: "SlackInfo", bundle: nil)
            let slackInfoVC = storyBoard.instantiateInitialViewController()
            self.navigationController?.pushViewController(slackInfoVC!, animated: true)
        case CellTypeIndex.watch.rawValue:
            let storyBoard = UIStoryboard(name: "ShareDataWithWatch", bundle: nil)
            let shareDataWithWatchVC = storyBoard.instantiateInitialViewController()
            self.navigationController?.pushViewController(shareDataWithWatchVC!, animated: true)
        default:
            break
        }
    }

}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellTypeIndex.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case CellTypeIndex.profile.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! UserInfoTableViewCell
            let userDefaults = UserDefaults.standard
            cell.userName = userDefaults.object(forKey: UserDefaultsKey.Profile.name) as? String
            cell.userCompany = userDefaults.object(forKey: UserDefaultsKey.Profile.company) as? String
            cell.userId = userDefaults.object(forKey: UserDefaultsKey.Profile.memId) as? String
            cell.imageUrl = userDefaults.object(forKey: UserDefaultsKey.Profile.imageUrl) as? String
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
            cell.cellSubTextLabel.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
