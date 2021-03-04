//
//  XXDataBase.swift
//  Pods-XXDataBase_Example
//
//  Created by solehe on 2021/3/3.
//

import Foundation
import WCDBSwift

public class XXDataBase: NSObject {

    /// 数据库工具类实例
    static let share = XXDataBase()
    
    /// 数据库实例
    var database: Database?
    
    /// 初始化方法
    private override init() {
        super.init()
    }
    
    /// 根据数据库名称打开数据库，没有则创建
    @objc public func open(name: String) {
        database = createDataBase(name)
    }
    
    /// 创建数据库
    private func createDataBase(_ name: String) -> Database {
        let path = XXDataBaseUtils.getCacheDir() + name;
        return Database(withFileURL:URL(fileURLWithPath:path))
    }
    
    /// 创建表
    public func createTable<T: TableDecodable>(table: String, of ttype:T.Type) -> Void {
        do {
            try database?.create(table: table, of: ttype)
        } catch let error {
            debugPrint("create table error \(error.localizedDescription)")
        }
    }
    
    /// 删除表
    public func deleteTable(table: String) -> Void {
        do {
            try database?.drop(table: table)
        } catch let error {
            debugPrint("deleteTable table error \(error)")
        }
    }
    
    /// 关闭数据库
    public func close() -> Void {
        database?.close()
    }
}

extension XXDataBase {
    
    /// 插入
    public func insert<T: TableEncodable>(
        objects: [T], // 需要插入的对象。WCDB Swift 同时实现了可变参数的版本，因此可以传入一个数组，也可以传入一个或多个对象。
        on propertyConvertibleList: [PropertyConvertible]? = nil, // 需要插入的字段
        intoTable table: String // 表名
        ) {
        do {
            try database?.insert(
                objects: objects,
                on: propertyConvertibleList,
                intoTable: table
            )
        } catch let error {
            debugPrint("insert obj error \(error.localizedDescription)")
        }
    }
    
    /// 插入或者替换
    public func insertOrReplace<T: TableEncodable>(
        objects: [T],
        on propertyConvertibleList: [PropertyConvertible]? = nil,
        intoTable table: String
        ) {
        do {
            try database?.insertOrReplace(
                objects: objects,
                on: propertyConvertibleList,
                intoTable: table
            )
        } catch let error {
            debugPrint("insertOrReplace obj error \(error.localizedDescription)")
        }
    }

    /// 更新
    public func update<T: TableEncodable>(
        table: String,
        on propertyConvertibleList: [PropertyConvertible],
        with object: T,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) {
        do {
            try database?.update(
                table: table,
                on: propertyConvertibleList,
                with: object,
                where: condition,
                orderBy: orderList,
                limit: limit,
                offset: offset
            )
        } catch let error {
            debugPrint("update obj error \(error.localizedDescription)")
        }
    }

    /// 删除
    public func delete(fromTable table: String, // 表名
        where condition: Condition? = nil, // 符合删除的条件
        orderBy orderList: [OrderBy]? = nil, // 排序的方式
        limit: Limit? = nil, // 删除的个数
        offset: Offset? = nil // 从第几个开始删除
        ) {
        do {
            try database?.delete(
                fromTable: table,
                where: condition,
                orderBy: orderList,
                limit: limit,
                offset: offset
            )
        } catch let error {
            debugPrint("delete error \(error.localizedDescription)")
        }
    }

    /// 查询
    public func getObjects<T: TableDecodable>(
        on propertyConvertibleList: [PropertyConvertible],
        fromTable table: String,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) -> [T]? {
        var list:[T]?
        do {
            try list = database?.getObjects(
                on: propertyConvertibleList,
                fromTable: table,
                where: condition,
                orderBy: orderList,
                limit: limit,
                offset: offset
            )
        } catch let error {
            debugPrint("getObjects error \(error.localizedDescription)")
        }
        return list
    }
    
}
