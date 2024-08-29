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
        setupBarButton()
    }
    // MARK: - UI Settings
    private func setupBarButton() {
           // 宣告按鈕
          /* let cancelButton = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(cancelButtonTapped))*/
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backaction))
        backButton.title = "返回"
        navigationItem.leftBarButtonItem = backButton

           // 增加按鈕
        navigationItem.title = "新增鬧鐘"
       }
    // MARK: - IBAction

    // MARK: - Function
    @objc private func backaction () {
            // 設定動作
        //dismiss(animated: true, completion: nil)
    }

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

