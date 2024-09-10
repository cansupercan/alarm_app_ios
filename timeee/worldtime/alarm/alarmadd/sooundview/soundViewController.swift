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
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
