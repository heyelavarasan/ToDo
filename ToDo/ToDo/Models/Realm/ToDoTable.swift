//
//  ToDoTable.swift
//  ToDo
//
//  Created ELAVARASAN K on 24/01/22.
//

import RealmSwift
import Foundation

class ToDoTable: Object
{
    @objc dynamic var primaryKeyId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var detail: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var status: String = ""
    @objc dynamic var isDeleted: Bool = false
    
    override class func primaryKey() -> String? {
        return "primaryKeyId"
    }
    
    func incrementId() -> Int
    {
        let realm = try! Realm()
        return (realm.objects(ToDoTable.self).max(ofProperty: "primaryKeyId") ?? 0) + 1
    }
}
