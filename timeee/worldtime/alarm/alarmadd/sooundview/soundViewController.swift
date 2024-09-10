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
    let sounmap = ["(長)戰意","戰意音樂完整版","出發","浩氣"]
    var seceltsoun = sound_value.shared.whosoun
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let indexPathrow = IndexPath(row: 0, section: 0)
        let cellt = tbvsousee.cellForRow(at: indexPathrow)
        cellt?.accessoryType = .checkmark
    }
    // MARK: - UI Settings
    
    // MARK: - IBAction
    
    
}
// MARK: - Function

// MARK: - Extensions
extension soundViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounmap.count
    }
    //更新畫面
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sounTableViewCell", for: indexPath) as! sounTableViewCell
        cell.lbsoundsee.text = sounmap[indexPath.row]
        return cell
    }
    //點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beforesoun = sound_value.shared.whosoun
        let indexPatht = IndexPath(row: beforesoun, section: 0)
        let cell1 = tbvsousee.cellForRow(at: indexPatht)
        let cell2 = tbvsousee.cellForRow(at: indexPath)
        
        
        
        cell1?.accessoryType = .none
        
        cell2?.accessoryType = .checkmark
        
        
        // 可選：點擊後取消選中狀態
        tableView.deselectRow(at: indexPatht, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        // print(day_value.shared.select)
    }
}
