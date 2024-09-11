//
//  soundViewController.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/9/10.
//

import UIKit
import RealmSwift

class soundViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tbvsousee: UITableView!
    // MARK: - Property
    let sounmap = ["震動","(長)戰意","戰意音樂完整版","出發","浩氣"]
    var seceltsoun = sound_value.shared.whosoun
    var first = false
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButton()
        soutableSet ()
        first = true
        tbvsousee.reloadData()
    }
    // MARK: - UI Settings
    private func setupBarButton() {
        // 宣告按鈕
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backaction))
        backButton.title = "返回"
        navigationItem.leftBarButtonItem = backButton
        
        // 增加按鈕
        navigationItem.title = "重複"
    }
    func soutableSet (){tbvsousee.register(UINib(nibName: "sounTableViewCell", bundle: nil),forCellReuseIdentifier: sounTableViewCell.identifier)
        tbvsousee.delegate = self
        tbvsousee.dataSource = self
        
    }
    // MARK: - IBAction
    
    // MARK: - Function
    @objc private func backaction () {
        // 設定動作
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - Extensions
extension soundViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounmap.count
    }
    //更新畫面
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sounTableViewCell", for: indexPath) as! sounTableViewCell
        cell.lbsoundsee.text = sounmap[indexPath.row]
        if self.first {
            cell.accessoryType = .checkmark
            self.first = false
        }
        return cell
    }
    //點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beforesoun = sound_value.shared.whosoun
        let indexPatht = IndexPath(row: beforesoun, section: 0)
        let cell1 = tbvsousee.cellForRow(at: indexPatht)
        let cell2 = tbvsousee.cellForRow(at: indexPath)
        sound_value.shared.whosoun = indexPath.row
        
        
        cell1?.accessoryType = .none
        
        cell2?.accessoryType = .checkmark
        
        
        // 可選：點擊後取消選中狀態
        tableView.deselectRow(at: indexPatht, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        // print(day_value.shared.select)
    }
}
