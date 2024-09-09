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
    var dayselect = [0,0,0,0,0,0,0]
     var daysee="永不"
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addtableSet()
        addsetUI()
        setupNavigationBarButton()
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
        //onedata.repeaT=尚未實作的功能
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
        if dayselect[0]==1 && dayselect[1]==1 && dayselect[2]==1 && dayselect[3]==1 && dayselect[4]==1 && dayselect[5]==1 && dayselect[6]==1 {daysee="每天"}
        else if dayselect[6]==1 && dayselect[5]==1{daysee="週末"}
        else if dayselect[1]==1 && dayselect[2]==1 && dayselect[0]==1 && dayselect[3]==1 && dayselect[4]==1{daysee="平日"}
        else{
            var times = 0
            for i in 0..<dayselect.count{
                if dayselect[i] == 0{
                    times+=1
                    switch (i){
                    case 0:
                        daysee += "週一 "
                        break
                    case 1:
                        daysee += "週二"
                        break
                    case 2:
                        daysee += "週三"
                        break
                    case 3:
                        daysee += "週四"
                        break
                    case 4:
                        daysee += "週五"
                        break
                    case 5:
                        daysee += "週六"
                        break
                    case 6:
                        daysee += "週日"
                        break
                    default:
                        break
                    }
                }
                if times == 0{
                    daysee="永不"
                }
            }
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
            cell.laloopsee.text = day_value.shared.daysee
            cell.accessoryType = .disclosureIndicator
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addmesTableViewCell", for: indexPath) as! addmesTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "soundTableViewCell", for: indexPath) as! soundTableViewCell
            cell.accessoryType = .disclosureIndicator
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addreTableViewCell", for: indexPath) as! addreTableViewCell
            return cell
        default:
            fatalError("Unexpected index path")
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

extension addViewController: RepViewControllerDelegate {
    func didSelectDays(checktimes: [Int]){
        self.dayselect = checktimes
        print(checktimes)
        tbvaddsee.reloadData()
    }
}

/*protocol addViewControllerDelegate:MainViewController{
 func mainData(editing:Bool,rows:Int){
 //self. = data
 }
 }*/
