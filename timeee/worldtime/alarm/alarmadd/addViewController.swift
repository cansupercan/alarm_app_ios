//
//  addViewController.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/19.
//

import UIKit
import RealmSwift

class addViewController: UIViewController {
    @IBOutlet weak var tbvaddsee: UITableView!
    
    @IBOutlet weak var dpktime: UIDatePicker!
    weak var delegate: addViewControllerDelegate?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            addtableSet()
        tbvaddsee.register(UINib(nibName: "addloopTableViewCell", bundle: nil), forCellReuseIdentifier: "addloopTableViewCell")
        tbvaddsee.register(UINib(nibName: "addmesTableViewCell", bundle: nil), forCellReuseIdentifier: "addmesTableViewCell")
        tbvaddsee.register(UINib(nibName: "soundTableViewCell", bundle: nil), forCellReuseIdentifier: "soundTableViewCell")
        tbvaddsee.register(UINib(nibName: "addreTableViewCell", bundle: nil), forCellReuseIdentifier: "addreTableViewCell")
        setupNavigationBarButton()
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
    @objc private func cancelButtonTapped () {
            // 設定動作
        let data1 = alarmDatatime(issave: false, hor: 0, min: 0, uptime: true)
        delegate?.passData(data1)
        dismiss(animated: true, completion: nil)
    }

    @objc private func saveButtonTapped() { //儲存
        //設定動作
        let ktime=dpktime.date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh"
        let hors = dateFormatter.string(from: ktime)
        let hori = Int(hors)
        
        dateFormatter.dateFormat = "mm"
        let mins = dateFormatter.string(from: ktime)
        let mini = Int(mins)
        
        dateFormatter.dateFormat = "a"
        let uptimes = dateFormatter.string(from: ktime)
        var uptimeb = false
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if uptimes == "AM"{
            uptimeb=true
        }
        let data1 = alarmDatatime(issave: true, hor: hori, min: mini, uptime: uptimeb)
        delegate?.passData(data1)
        //dismiss(animated: true, completion: nil)
    }
    func addtableSet (){tbvaddsee.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier: TableViewCell.identifier)
        tbvaddsee.delegate = self
        tbvaddsee.dataSource = self
        
    }
    /*
    // MARK: - Navigation

   
    */

}

extension addViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    //更新畫面
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "addloopTableViewCell", for: indexPath) as! addloopTableViewCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "addmesTableViewCell", for: indexPath) as! addmesTableViewCell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "soundTableViewCell", for: indexPath) as! soundTableViewCell
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "addreTableViewCell", for: indexPath) as! addreTableViewCell
                return cell
            default:
                fatalError("Unexpected index path")
            }
        }
    }


protocol addViewControllerDelegate:AnyObject {
    func passData(_ data: alarmDatatime)
}

