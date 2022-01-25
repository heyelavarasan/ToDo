//
//  AddToDoViewController.swift
//  ToDo
//
//  Created by ELAVARASAN K on 25/01/22.
//

import Foundation
import UIKit

protocol AddToDoDelegate {
    func addToDoDidSave(_ eventFilterType: ToDoFilter)
}

class AddToDoViewController: UIViewController
{
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var saveBtn: UIButton!
    
    private var addToDoVM = ManageToDoViewModel()
    var delegate: AddToDoDelegate?
    var editingToDoViewModel: ToDoViewModel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        eventDatePicker.minimumDate = Date()
        
        if let safeEditingToDoViewModel = editingToDoViewModel
        {
            titleTextField.text = safeEditingToDoViewModel.title
            descriptionTextField.text = safeEditingToDoViewModel.description
            eventDatePicker.setDate(safeEditingToDoViewModel.date, animated: true)
            saveBtn.setTitle("Update", for: .normal)
        }
        else
        {
            eventDatePicker.setDate(Date(), animated: true)
            saveBtn.setTitle("Save", for: .normal)
        }
    }
    
    @IBAction func saveToDoBtnAction(_ sender: UIButton)
    {
        if let title = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), title != "", let detail = descriptionTextField.text
        {
            let todoVMObj = ToDoViewModel()
            todoVMObj.primaryKey = editingToDoViewModel?.primaryKey
            todoVMObj.title = title
            todoVMObj.description = detail
            todoVMObj.date = eventDatePicker.date
            
            addToDoVM.commitToDoItemDetails(for: todoVMObj) { status in
                if status
                {
                    if let safeFilterType = CommonMethod.GetToDoTaskFilterType(todoVMObj.date)
                    {
                        self.delegate?.addToDoDidSave(safeFilterType)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        else
        {
            let alert = UIAlertController(title: "Alert!", message: "Please enter the mandatory details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelBtnAction(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
