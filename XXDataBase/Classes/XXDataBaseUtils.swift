//
//  XXDataBaseUtils.swift
//  Pods-XXDataBase_Example
//
//  Created by solehe on 2021/3/3.
//

import Foundation

class XXDataBaseUtils {
    
    // 数据库存放路径
    static func getCacheDir() -> String {
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        return dir! + "/db/"
    }
    
}
