//
//  ViewController.swift
//  XXDataBase
//
//  Created by solehe on 03/03/2021.
//  Copyright (c) 2021 solehe. All rights reserved.
//

import UIKit
import XXDataBase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // 创建表
        XXDataBase.share.createTable(table: "User", of: User.self)
        
        // 初始化数据
        let user = User(name: "solehe", sex: " 男")
        
        // 插入数据
        XXDataBase.share.insertOrReplace(objects: [user], on: User.Properties.all, intoTable: "User")
        
        // 删除数据
        XXDataBase.share.delete(
            fromTable: "User",
            where: User.Properties.id >= 3,
            orderBy: nil,
            limit: nil,
            offset: nil
        )
        
        // 查询数据
        let users: [User]? = XXDataBase.share.getObjects(
            on: User.Properties.all,
            fromTable: "User",
            where: nil,
            orderBy: nil,
            limit: nil,
            offset: nil
        )
        print("查询结果：\(String(describing: users?.description))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

