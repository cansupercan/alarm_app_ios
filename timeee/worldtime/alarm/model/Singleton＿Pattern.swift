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
    private init() {}
}
