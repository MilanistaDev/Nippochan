//
//  ShareDataWithWatchViewController.swift
//  NippoChan
//
//  Created by 麻生 拓弥 on 2018/12/17.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

final class ShareDataWithWatchViewController: UIViewController {

    @IBOutlet weak var addWordView: UIView!
    @IBOutlet weak var addWordTextField: UITextField!
    @IBOutlet weak var wordListTableView: UITableView!
    @IBOutlet weak var shareDataButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.displayViewWithAnimation(isHidden: true)
    }

    fileprivate func setUpUI() {
        self.shareDataButton.layer.cornerRadius = 5.0
        self.shareDataButton.layer.masksToBounds = true
    }

    fileprivate func setUpTableView() {
        self.wordListTableView.contentInset.bottom = 80.0
        self.wordListTableView.delegate = self
        self.wordListTableView.dataSource = self
    }

    private func displayViewWithAnimation(isHidden: Bool) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [],
                       animations: { [weak self] in
                        self?.addWordView.isHidden = isHidden
            }, completion: nil)
    }

    @IBAction func addWordAction(_ sender: Any) {
        self.displayViewWithAnimation(isHidden: true)
        self.wordListTableView.reloadData()
    }

    @IBAction func addNewWordAction(_ sender: Any) {
        self.displayViewWithAnimation(isHidden: false)
    }
}

extension ShareDataWithWatchViewController: UITableViewDelegate {

}

extension ShareDataWithWatchViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        cell.textLabel?.text = indexPath.row.description
        return cell
    }
}
