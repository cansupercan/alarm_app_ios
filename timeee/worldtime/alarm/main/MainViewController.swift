//
//  MainViewController.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/16.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tbvsee: UITableView!
    
    @IBOutlet weak var bbtimer: UITabBarItem!
    @IBOutlet weak var bbcount: UITabBarItem!
    @IBOutlet weak var bbworldtime: UITabBarItem!
    @IBOutlet weak var bbalarm: UITabBarItem!
    var delegate: MainViewController?
    // MARK: - Property
    var isedit:Bool = false
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        func passData(_ data: alarmDatatime) {
               // print("接收到的鬧鐘: \(data.hor) 小时, \(data.min) 分钟, uptime: \(data.uptime)")
                // 在这里处理接收到的数据
            }
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
        navigationItem.rightBarButtonItem = btnRight

    }
    
    
    
    // MARK: - UI Settings
    
    // MARK: - IBAction
    @objc func addalarm(){
        let addVC = addViewController()
        //addVC.delegate = self
        let navigationController = UINavigationController(rootViewController: addVC)
        self.present(navigationController, animated: true)
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
        cell.lbnoon.text = eetime
        cell.lbtime.text = "\(nowdata.timehor):\(nowdata.timemin)"
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
    
}

extension MainViewController: addViewControllerDelegate {
    func passData(_ data: alarmDatatime) {
       
    }
}


