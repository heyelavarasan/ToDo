//
//  AddToDoViewModel.swift
//  ToDo
//
//  Created by ELAVARASAN K on 25/01/22.
//

import Foundation
import RealmSwift

class ManageToDoViewModel
{
    static let shared = ManageToDoViewModel()
    
    func commitToDoItemDetails(for todoVM: ToDoViewModel, completion: @escaping (Bool) -> ())
    {
        let realmObj: ToDoTable!
        let realm = try! Realm()
        
        if let editingToDoObj = realm.objects(ToDoTable.self).filter({$0.primaryKeyId == todoVM.primaryKey}).first
        {
            realmObj = editingToDoObj
        }
        else
        {
            realmObj = ToDoTable()
            realmObj.primaryKeyId = realmObj.incrementId()
        }
        
        try! realm.write {
            realmObj.title = todoVM.title
            realmObj.detail = todoVM.description
            realmObj.date = todoVM.date
            //realmObj.status = todoVM.status
            //realmObj.isDeleted = todoVM.status
            realm.add(realmObj, update: .modified)
            completion(true)
        }
    }
    
    func deleteToDoItem(for primaryKeyId : Int, completion: @escaping (Bool) -> ())
    {
        let realm = try! Realm()
        let deletingResults = realm.objects(ToDoTable.self).filter({$0.primaryKeyId == primaryKeyId})
        
        try! realm.write {
            realm.delete(deletingResults)
            completion(true)
        }
    }
    
}
