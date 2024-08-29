//
//  repViewController.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/28.
//

import UIKit

class repViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tbvrepsee: UITableView!
    // MARK: - Property
    var day = ["星期一","星期二","星期三","星期四","星期五","星期六","星期天"]
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: - UI Settings

    // MARK: - IBAction

    // MARK: - Function

}
// MARK: - Extensions

extension repViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return day.count
    }
    //更新畫面
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tbvrepsee.dequeueReusableCell(withIdentifier: "repTableViewCell",for: indexPath) as? repTableViewCell else {
            return UITableViewCell()
        }
        // 設定文本
        cell.lareptbvlab.text = day[indexPath.row]
        return cell
        }
    }

