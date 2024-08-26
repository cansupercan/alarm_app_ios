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
    
    var delegate: addViewControllerDelegate?
    var horf=1,minf=0,uptimef=true
    
    
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
        dismiss(animated: true, completion: nil)
    }

    @objc private func saveButtonTapped() {
        //設定動作
        let realm = try! Realm()
        let dataala = clockdata()
        if let maxTid = realm.objects(clockdata.self).max(ofProperty: "tid") as Int? {
            dataala.tid = maxTid + 1
        } else {
            dataala.tid = 1
        }
        
        try! realm.write {
            realm.add(dataala)
        }
        dismiss(animated: true, completion: nil)
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

protocol addViewControllerDelegate {
    func passData(uptimef:Bool,horf:Int,minf:Int)
}

