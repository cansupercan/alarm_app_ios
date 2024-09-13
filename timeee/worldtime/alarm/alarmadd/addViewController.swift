//
//  addViewController.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/19.
//

import UIKit
import RealmSwift

class addViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var tbvaddsee: UITableView!
    
    @IBOutlet weak var dpktime: UIDatePicker!
    // MARK: - Property
    weak var delegate: addViewControllerDelegate?
    var isedit = false
    var rows = 0
    var selectedDay = [Int]()
    var swwaitnow = true
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        swwait_value.shared.swwait = swwaitnow
        addtableSet()
        addsetUI()
        setupNavigationBarButton()
        addsetrep()
        sound_value.shared.whosoun = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        tbvaddsee.reloadData()
    }
    // MARK: - UI Settings
    
    func addsetUI() {
        tbvaddsee.register(UINib(nibName: "addloopTableViewCell", bundle: nil), forCellReuseIdentifier: "addloopTableViewCell")
        tbvaddsee.register(UINib(nibName: "addmesTableViewCell", bundle: nil), forCellReuseIdentifier: "addmesTableViewCell")
        tbvaddsee.register(UINib(nibName: "soundTableViewCell", bundle: nil), forCellReuseIdentifier: "soundTableViewCell")
        tbvaddsee.register(UINib(nibName: "addreTableViewCell", bundle: nil), forCellReuseIdentifier: "addreTableViewCell")
    }
    private func setupNavigationBarButton() {
        // 宣告按鈕
        let cancelButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        // 宣告按鈕
        let saveButton = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(saveButtonTapped))
        // 增加按鈕
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "新增鬧鐘"
    }
    func addsetrep(){
        if isedit{
            day_value.shared.select = [Int]()
        }else{
            day_value.shared.select = [Int]()
        }
    }
    // MARK: - IBAction
    
    // MARK: - Function
    @objc private func cancelButtonTapped () {
        // 設定動作
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        //對date picker 取值
        let ktime = dpktime.date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh"
        guard let hors = dateFormatter.string(from: ktime) as String?,
              let hori = Int(hors) else {
                  print("Error: Unable to convert hour.")
                  return
              }
        
        dateFormatter.dateFormat = "mm"
        guard let mins = dateFormatter.string(from: ktime) as String?,
              let mini = Int(mins) else {
                  print("Error: Unable to convert minute.")
                  return
              }
        
        dateFormatter.dateFormat = "a"
        let uptimes = dateFormatter.string(from: ktime)
        var uptimeb = false
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if uptimes == "AM"{
            uptimeb=true
        }
        let data1 = alarmDatatime(issave: true, hor: hori, min: mini, uptime: uptimeb)
        //存進realm
        let realm = try! Realm()
        let onedata = clockdata()
        onedata.timehor = hori
        onedata.timemin = mini
        onedata.turnsw = true
        onedata.uptime=uptimeb
        let maxTid = realm.objects(clockdata.self).max(ofProperty: "tid") as Int? ?? 0
        let newTid = maxTid + 1
        onedata.tid=newTid
        
        let cellmes = tbvaddsee.cellForRow(at: IndexPath(row: 1, section: 0)) as? addmesTableViewCell
        // 獲取 lbmes.text 並設置到 onedata.message
        onedata.message = cellmes?.txfmes.text ?? ""
        //儲存重複天數
        var dayst = ""
        for i in 0..<day_value.shared.select.count{
            dayst = dayst+"\(day_value.shared.select[i]),"
        }
        onedata.repeadate = dayst
        //音樂
        onedata.sound = sound_value.shared.whosoun
        //稍後提醒
        onedata.waitsw = swwait_value.shared.swwait
        try! realm.write {
            realm.add(onedata)
        }
        
        //回傳並關閉畫面
        delegate?.passData(data1)
        dismiss(animated: true, completion: nil)
        
    }
    func addtableSet (){tbvaddsee.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier: TableViewCell.identifier)
        tbvaddsee.delegate = self
        tbvaddsee.dataSource = self
        
    }
    func setloopcell()  {
        var repeatDay: String
        selectedDay = day_value.shared.select
        if selectedDay == [0,1, 2, 3, 4] { // 星期一到五
            repeatDay = "平日"
        } else if selectedDay == [5,6] { // 星期六和日
            repeatDay = "週末"
        } else if selectedDay == [0, 1, 2, 3, 4, 5, 6] { // 每天
            repeatDay = "每天"
        } else if selectedDay.isEmpty { // 沒有選擇任何天
            repeatDay = "永不"
        } else {
            // 將選擇的天數名稱連接成一個字串
            let dayNames = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六","星期天"]
            let selectedDayNames = selectedDay.map { dayNames[$0] }
            repeatDay = selectedDayNames.joined(separator: ", ")
        }
        day_value.shared.daysee = repeatDay
      //  print(day_value.shared.daysee)
    }
    //處理稍後提醒的ＳＷ
    @objc func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            print("Switch is ON")
        } else {
            print("Switch is OFF")
        }
    }

    
}
// MARK: - Extensions
extension addViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    //更新畫面
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addloopTableViewCell", for: indexPath) as! addloopTableViewCell
            setloopcell()
            let selectedDayNames = day_value.shared.daysee
            cell.laloopsee.text = selectedDayNames
            cell.accessoryType = .disclosureIndicator
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addmesTableViewCell", for: indexPath) as! addmesTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "soundTableViewCell", for: indexPath) as! soundTableViewCell
            cell.accessoryType = .disclosureIndicator
            let rowsou = sound_value.shared.whosoun
            cell.lasounsee.text = sound_value.shared.mapsoun[rowsou]
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addreTableViewCell", for: indexPath) as! addreTableViewCell
            cell.swwaitIB.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
            return cell
        default:
            return UITableViewCell()
            
        }
    }
    //設定點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 當單元格被點擊時執行跳轉
        switch(indexPath.row){
        case 0:
            let addVC = repViewController()
            navigationController?.pushViewController(addVC, animated: true)
            break
        case 2:
            let addVC = soundViewController()
            navigationController?.pushViewController(addVC, animated: true)
            break
        default:
            print("dd")
        }
        
    }
}


protocol addViewControllerDelegate:AnyObject {
    func passData(_ data: alarmDatatime)
}
extension addViewController: MainViewControllerDelegate {
    func mainData(editing:Bool,rows:Int){
        self.rows = rows
        self.isedit = editing
    }
}




