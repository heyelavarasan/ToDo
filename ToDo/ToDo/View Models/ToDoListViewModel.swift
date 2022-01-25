//
//  ToDoListViewModel.swift
//  ToDo
//
//  Created by ELAVARASAN K on 23/01/22.
//

import Foundation
import RealmSwift

enum ToDoFilter: Int
{
    case Today = 0
    case Tomorrow
    case Upcoming
}

class ToDoListViewModel {
    
    private var todoListViewModels = [ToDoViewModel]()
    private var completeToDoListViewModels = [ToDoViewModel]()
    
    func refreshToDoList()
    {
        let realm = try! Realm()
        let realmResults = realm.objects(ToDoTable.self).filter({!$0.isDeleted}).sorted { $0.date > $1.date }
        completeToDoListViewModels = realmResults.map { todoTableObj -> ToDoViewModel in
            print("ToDoTableResultsObj..", todoTableObj)
            let todoViewModelObj = ToDoViewModel()
            todoViewModelObj.primaryKey = todoTableObj.primaryKeyId
            todoViewModelObj.title = todoTableObj.title
            todoViewModelObj.description = todoTableObj.detail
            todoViewModelObj.date = todoTableObj.date
            return todoViewModelObj
        }
    }
    
    func addToDoListViewModel(_ vm: ToDoViewModel) {
        todoListViewModels.append(vm)
    }
    
    func numberOfRows(_ section: Int = 0) -> Int {
        return todoListViewModels.count
    }
    
    func modelAt(_ index: Int) -> ToDoViewModel {
        return todoListViewModels[index]
    }
    
    func updateToDoList(by filter: ToDoFilter)
    {
        todoListViewModels = completeToDoListViewModels.filter { vm in
            switch filter
            {
            case .Today:
                if Calendar.current.isDateInToday(vm.date)
                {
                    return true
                }
            case .Tomorrow:
                if Calendar.current.isDateInTomorrow(vm.date)
                {
                    return true
                }
            case .Upcoming:
                if vm.date > Date()
                {
                    return true
                }
            }
            return false
        }
    }
}

class ToDoViewModel
{
    var primaryKey: Int?
    var title: String
    var description: String
    var date: Date
    
    
    init(todoItem: ToDoTable) {
        self.primaryKey = todoItem.primaryKeyId
        self.title = todoItem.title
        self.description = todoItem.detail
        self.date = todoItem.date
    }
    
    init() {
        self.title = ""
        self.description = ""
        self.date = Date()
    }
    
    var displayDate: String {
        return CommonMethod.CustomDateFormatter(self.date)
    }
}


