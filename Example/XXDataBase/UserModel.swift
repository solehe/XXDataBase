//
//  UserModel.swift
//  XXDataBase_Example
//
//  Created by solehe on 2021/3/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import WCDBSwift

class User: TableCodable {
    
    var name: String?
    var sex: String?
    var age: Int?
    var id: Int?
    
    init(name: String, sex: String) {
        self.name = name
        self.sex = sex
    }
    
    enum CodingKeys: String, CodingTableKey {
        
        typealias Root = User
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)

        case name
        case sex
        case age
        case id
        
        // Column constraints for primary key, unique, not null, default value and so on. It is optional.
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                .id: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
            ]
        }
    }
}

