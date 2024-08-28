//
//  model.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/19.
//

import Foundation
import UIKit
import RealmSwift

class clockdata: Object {
    @objc dynamic var tid: Int = 0
    @objc dynamic var uptime: Bool = true
    @objc dynamic var timehor:Int = 1
    @objc dynamic var timemin:Int = 1
    @objc dynamic var repeadate:String = ""
    @objc dynamic var message: String = ""
    @objc dynamic var turnsw: Bool = false
    
    //設定索引主題
    /*  override static func primaryKey() -> String? {
     return "uuid"
     }*/
    
    convenience init(timemin: Int,
                     tid: Int,
                     timehor: Int,
                     repeadate: String,
                     message: String,
                     uptime: Bool,
                     turnsw: Bool ) {
        self.init()
        self.tid = tid
        self.timehor = timehor
        self.timemin = timemin
        self.uptime = uptime
        self.repeadate = repeadate
        self.message = message
        self.turnsw = turnsw
        
    }
}
struct alarmDatatime {
    var issave:Bool
    var hor: Int
    var min: Int
    var uptime:Bool
}

class day_value {
    var select = [0,0,0,0,0,0,0]
    var daysee="永不>"
    static let shared = day_value()
    private init() {}
}
