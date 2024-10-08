//
//  MainViewController.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/16.
//

import UIKit
import RealmSwift
import SwiftUI
import UserNotifications

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

    var sortdat:Results<clockdata>? = nil
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(sortdat)
        setUI()
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        sortdata()
    }
    override func viewWillAppear(_ animated: Bool) {
        sortdata()
        tbvsee.reloadData()
        print("22222")
    }
    func sortdata(){
        let realm = try! Realm()
        sortdat = realm.objects(clockdata.self)
        
        // 使用 sorted 函式根據時間進行排序
        let sortedClockData = sortdat?.sorted {
            if $0.uptime == $1.uptime {
                if $0.timehor == $1.timehor {
                    return $0.timemin < $1.timemin
                }
                return $0.timehor < $1.timehor
            }
            return $0.uptime && !$1.uptime
        }
        
        // 將排序後的 tid 存入 sorted 陣列
        id_value.shared.sorted = sortedClockData?.map { $0.tid } ?? []
        
        // Debug 印出排序結果
        print(id_value.shared.sorted)
    }
    func setUI(){
        tableSet()
        setnev()
        settavUI()
    }
    func settavUI(){
        tbvsee.register(UINib(nibName: "sleepTableViewCell", bundle: nil), forCellReuseIdentifier: "sleepTableViewCell")
    }
    func tableSet(){tbvsee.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier: TableViewCell.identifier)
        tbvsee.delegate = self
        tbvsee.dataSource = self
        
    }
    func setnev(){
        self.title = "鬧鐘"
        navigationController?.navigationBar.prefersLargeTitles = true
        let btnRight = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addalarm))
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.rightBarButtonItem = btnRight
        
    }
    
    
    
    // MARK: - UI Settings
    
    // MARK: - IBAction
    @objc func addalarm(){
        let addVC = addViewController()
        addVC.delegate = self
        let navigationController = UINavigationController(rootViewController: addVC)
        self.present(navigationController, animated: true)
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tbvsee.setEditing(editing, animated: animated)
    }
    // MARK: - Function
    @objc func witchToggled(_ sender: UISwitch) {
        let row = sender.tag
        let tid = id_value.shared.sorted[row]
        let realm = try! Realm()
        let allObjects = realm.objects(clockdata.self)
        let id = "\(row)"
        
        // 查找對應的資料
        if let data = allObjects.filter("tid == %@", tid).first {
            let min = data.timemin
            let hor = data.timehor
            let uptime = data.uptime
            let mes = data.message
            
            if sender.isOn {
                // 設置鬧鐘時間
                createNotification(hour: hor, minute: min, uptime: uptime, message: mes, id: id)
            } else {
                removeNotification(withId: id)
            }
            
            try! realm.write {
                data.turnsw = sender.isOn
            }
        } else {
            print("找不到符合的資料")
        }
    }
    //設定鬧鐘的func
    func removeNotification(withId id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func createNotification(hour: Int, minute: Int, uptime: Bool, message: String, id: String) {
        // 設定通知內容
        let content = UNMutableNotificationContent()
        content.title = "鬧鐘"
        content.subtitle = "\(hour):\(minute)"
        content.body = message
        content.badge = 1
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "alarmMessage"
        
        // 設定上下午
        var hour24 = hour
        
        // 根據 uptime 設定 24 小時制的時間
        if uptime == false { // PM 時間
            if hour != 12 { // 如果小時不是 12，則需要加 12
                hour24 += 12
            }
        } else { // AM 時間
            if hour == 12 { // 如果小時是 12，則設為 0
                hour24 = 0
            }
        }
        
        // 建立 DateComponents 以設定通知觸發時間
        var dateComponents = DateComponents()
        dateComponents.hour = hour24
        dateComponents.minute = minute
        
        // 設定通知觸發器
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // 設定通知請求
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        // 添加通知請求
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("通知添加錯誤: \(error.localizedDescription)")
            }
        }
    }
    
}

// MARK: - Extensions
extension MainViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // 設定第一個 section 的行數
        } else {
            let realm = try! Realm()
            let datacount = realm.objects(clockdata.self).count
            return datacount
        }
    }
    //更新畫面
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            guard let cell = tbvsee.dequeueReusableCell(withIdentifier: "sleepTableViewCell", for: indexPath) as? sleepTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            guard let cell = tbvsee.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
                return UITableViewCell()
            }
            sortdata()
            let nowid = id_value.shared.sorted[indexPath.row]
            let realm = try! Realm()
            let mydata = realm.objects(clockdata.self)
            
            // 確保找到對應的資料
            if let nowdata = mydata.filter("tid == %@", nowid).first {
                // 處理上午/下午時間顯示
                let eetime = nowdata.uptime ? "上午" : "下午"
                
                // 補零處理
                var minzero = "\(nowdata.timemin)"
                if nowdata.timemin < 10 {
                    minzero = "0\(nowdata.timemin)"
                }
                
                // 設定時間與開關狀態
                cell.lbnoon.text = eetime
                cell.lbtime.text = "\(nowdata.timehor):\(minzero)"
                cell.swturn.isOn = nowdata.turnsw
                
                // 處理重複日期的顯示
                var repeatDay: String
                var dayst = nowdata.repeadate
                if dayst.hasSuffix(",") {
                    dayst.removeLast()
                }
                let daystArray = dayst.components(separatedBy: ",")
                var days = [Int]()
                for day in daystArray {
                    if let dayInt = Int(day) {
                        days.append(dayInt)
                    }
                }
                let selectedDay = days
                
                // 判斷選擇的天數
                if selectedDay == [0, 1, 2, 3, 4] { // 星期一到五
                    repeatDay = "平日"
                } else if selectedDay == [5, 6] { // 星期六和日
                    repeatDay = "週末"
                } else if selectedDay == [0, 1, 2, 3, 4, 5, 6] { // 每天
                    repeatDay = "每天"
                } else if selectedDay.isEmpty { // 沒有選擇任何天
                    repeatDay = "永不"
                } else {
                    // 將選擇的天數名稱連接成字串
                    let dayNames = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期天"]
                    let selectedDayNames = selectedDay.map { dayNames[$0] }
                    repeatDay = selectedDayNames.joined(separator: ", ")
                }
                
                // 處理鬧鐘訊息與重複日期的顯示
                if nowdata.message.isEmpty {
                    if nowdata.repeadate.isEmpty {
                        cell.lbunder.text = "鬧鐘"
                    } else {
                        cell.lbunder.text = "鬧鐘．\(repeatDay)"
                    }
                } else {
                    if nowdata.repeadate.isEmpty {
                        cell.lbunder.text = "\(nowdata.message)"
                    } else {
                        cell.lbunder.text = "\(nowdata.message)．\(repeatDay)"
                    }
                }
                
                // 添加開關動作
                cell.swturn.tag = indexPath.row
                cell.swturn.addTarget(self, action: #selector(witchToggled(_:)), for: .valueChanged)
            } else {
                print("找不到符合的資料")
            }
            
            return cell
        }
    }
    //設定標題
    //設定字數
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // 設置為 2，表示有兩個 section
    }
    //設定內容
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let realm = try! Realm()
        sortdat = realm.objects(clockdata.self)
        headerView.backgroundColor = .systemBackground // 設定背景色
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if section == 0 {
            // 設定圖片附件
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "bed.double.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .regular))
            
            let imageString = NSAttributedString(attachment: imageAttachment)
            let fullString = NSMutableAttributedString(string: "")
            fullString.append(imageString)
            fullString.append(NSAttributedString(string: " 睡眠｜起床鬧鐘"))
            
            label.attributedText = fullString
        } else {
            label.text = "其他"
        }
        
        headerView.addSubview(label)
        
        // 設定 Label 的佈局
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 // 設定標題的高度
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
            let nowid = id_value.shared.sorted[indexPath.row]
            if let onedata = todos.filter("tid == %@", nowid).first {
                   
                    // 開啟寫入交易，並刪除資料
                    try! realm.write {
                        realm.delete(onedata)
                    }

                    // 刪除行並添加刪除動畫
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } else {
                    print("找不到符合的資料")
                }
            
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
        let nowid = id_value.shared.sorted[indexPath.row]
        delegatem?.mainData(editing: true, rows: nowid)
        let addVC = addViewController()
        addVC.delegate = self
        let navigationController = UINavigationController(rootViewController: addVC)
        edit_value.shared.row = nowid
        edit_value.shared.isediting = true
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

