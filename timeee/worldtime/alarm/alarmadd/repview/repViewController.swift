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
    let day = ["星期一","星期二","星期三","星期四","星期五","星期六","星期天"]
    var checktime = [Int]()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButton()
        reptableSet()
        checktime=day_value.shared.select
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
    // MARK: - IBAction
    
    // MARK: - Function
    @objc private func backaction () {
        // 設定動作
        navigationController?.popViewController(animated: true)
    }
    func reptableSet (){tbvrepsee.register(UINib(nibName: "repTableViewCell", bundle: nil),forCellReuseIdentifier: repTableViewCell.identifier)
        tbvrepsee.delegate = self
        tbvrepsee.dataSource = self
        
    }
    
}
// MARK: - Extensions
//tableview設定
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
        var checktimes=[0,0,0,0,0,0,0]
        for i in 0..<checktime.count{
            checktimes[checktime[i]] = 1
        }
        if checktimes[indexPath.row] == 0 {
            cell.accessoryType = .none
            
        }else{
            cell.accessoryType = .checkmark
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var check = 1
        if let cell = tbvrepsee.cellForRow(at: indexPath) {
            // 切換勾選狀態
            if cell.accessoryType == .checkmark {
                let datev=day_value.shared
                datev.removeitem(value:indexPath.row)
                datev.sortSelect()
                cell.accessoryType = .none
                check = 0
            } else {
                day_value.shared.select.append(indexPath.row)
                let datev=day_value.shared
                datev.sortSelect()
                cell.accessoryType = .checkmark
                
            }
            var checktimes=[0,0,0,0,0,0,0]
            for i in 0..<checktime.count{
                checktimes[checktime[i]] = 1
            }
            checktimes[indexPath.row] = check
            // 可選：點擊後取消選中狀態
            tableView.deselectRow(at: indexPath, animated: true)
           // print(day_value.shared.select)
        }
    }
}

//定義傳值

