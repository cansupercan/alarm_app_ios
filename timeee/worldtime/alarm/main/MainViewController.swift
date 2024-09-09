//
//  MainViewController.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/16.
//

import UIKit
import RealmSwift
import SwiftUI

class MainViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tbvsee: UITableView!
    
    @IBOutlet weak var bbtimer: UITabBarItem!
    @IBOutlet weak var bbcount: UITabBarItem!
    @IBOutlet weak var bbworldtime: UITabBarItem!
    @IBOutlet weak var bbalarm: UITabBarItem!
    var delegatem: MainViewControllerDelegate?
    // MARK: - Property
    var isedit:Bool = false
    var adddata: alarmDatatime?
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func setUI(){
        tableSet()
        setnev()
    }
    
    func tableSet(){tbvsee.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier: TableViewCell.identifier)
        tbvsee.delegate = self
        tbvsee.dataSource = self
        
    }
    func setnev(){
        self.title = "鬧鐘"
        navigationController?.navigationBar.prefersLargeTitles = true
        let btnRight = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addalarm))
        let btnlight = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editfunc))
        navigationItem.rightBarButtonItem = btnRight
        navigationItem.leftBarButtonItem = btnlight
        
    }
    
    
    
    // MARK: - UI Settings
    
    // MARK: - IBAction
    @objc func addalarm(){
        let addVC = addViewController()
        addVC.delegate = self
        let navigationController = UINavigationController(rootViewController: addVC)
        self.present(navigationController, animated: true)
    }
    @objc func editfunc() {
        print("edit")
    }
    // MARK: - Function
    
    
    
    
    
}

// MARK: - Extensions
extension MainViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let datacount = realm.objects(clockdata.self).count
        return datacount
    }
    //更新畫面
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tbvsee.dequeueReusableCell(withIdentifier: "TableViewCell",for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let currentDog = indexPath.row
        let realm = try! Realm()
        let mydata=realm.objects(clockdata.self)
        let nowdata=mydata[currentDog]
        var eetime=""
        if(nowdata.uptime){
            eetime="上午"
        }else{
            eetime="下午"
        }
        // 設定文本
        var minzero = "\(nowdata.timemin)" //給個位數字補零
        if( nowdata.timemin<10) {
            minzero = "0\(nowdata.timemin)"
        }
        cell.lbnoon.text = eetime
        cell.lbtime.text = "\(nowdata.timehor):\(minzero)"
        cell.swturn.isOn = nowdata.turnsw
        return cell
    }
    //右滑功能
    // 配置 UISwipeActionsConfiguration
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // 創建一個 "移除" 操作
        let removeAction = UIContextualAction(style: .normal, title: "移除") { (_, _, completionHandler) in
            
            // 移除數據（這裡簡單地使用一個數組作為示例）
            let realm = try! Realm()
            let todos = realm.objects(clockdata.self)
            let onedata = todos[indexPath.row]
            try! realm.write {
                realm.delete(onedata)
            }
            
            // 刪除行並添加刪除動畫
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // 完成操作
            completionHandler(true)
        }
        
        // 設定操作的背景顏色
        removeAction.backgroundColor = UIColor.red
        
        // 返回配置
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 當單元格被點擊時執行跳轉
        delegatem?.mainData(editing: true, rows: indexPath.row)
        let addVC = addViewController()
        addVC.delegate = self
        let navigationController = UINavigationController(rootViewController: addVC)
        self.present(navigationController, animated: true)
    }
}
//接收傳值(addviw)
extension MainViewController: addViewControllerDelegate {
    func passData(_ data: alarmDatatime){
        self.adddata = data
        tbvsee.reloadData()
        //print("Received data: \(data)")
    }
}
//傳送傳值(addview)
protocol MainViewControllerDelegate:AnyObject {
    func mainData(editing:Bool,rows:Int)
}
/*
 extension MainViewController: AnyObject {
 func mainData(editing:Bool,rows:Int)
 }
 */
