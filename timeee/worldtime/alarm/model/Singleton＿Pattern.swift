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
    let mapsoun = ["震動","(長)戰意","戰意音樂完整版","出發","浩氣"]
    static let shared = sound_value()
    private init() {}
}
class swwait_value{
    var swwait = true
    static let shared = swwait_value()
    private init() {}
}
class edit_value{
    var isediting = false
    var row = 0
    static let shared = edit_value()
    private init() {}
}
class id_value{
    var sorted = [Int]()
    static let shared = id_value()
    private init() {}
}
