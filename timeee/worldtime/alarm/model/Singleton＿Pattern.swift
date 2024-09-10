//
//  Singleton＿Pattern.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/29.
//

import Foundation

struct alarmDatatime {
    var issave:Bool
    var hor: Int
    var min: Int
    var uptime:Bool
}

class day_value {
    var select = [Int]()
    var daysee:String="永不"
    static let shared = day_value()
    func sortSelect() {
            // 對 select 陣列進行升序排序
            select.sort()
        }
    func removeitem(value: Int) {
            if let index = select.firstIndex(of: value) {
                select.remove(at: index)
            } else {
                print("Value not found in the array")
            }
        }
    private init() {}
}

class sound_value{
    var whosoun = 0
    static let shared = sound_value()
    private init() {}
}
