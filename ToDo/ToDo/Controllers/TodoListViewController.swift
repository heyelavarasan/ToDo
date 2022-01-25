//
//  TodoListViewController.swift
//  ToDo
//
//  Created by ELAVARASAN K on 23/01/22.
//

import UIKit

class TodoListViewController: UITableViewController
{
    //MARK:- IBOutlet Connections
    @IBOutlet weak var todoFilterSC: UISegmentedControl!
    @IBOutlet var noDataView: UIView!
    @IBOutlet weak var editingModeNavBarBtn: UIBarButtonItem!
    
    //MARK:- Variable Declarations
    private var todoListViewModel = ToDoListViewModel()
    
    //MARK:- Setup Controller
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UINib(nibName: "ToDoListTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoListTableViewCell")
        tableView.backgroundView = noDataView
        reloadList()
    }
    
    private func reloadList(isReloadVM: Bool = true)
    {
        if isReloadVM
        {
            todoListViewModel.refreshToDoList()
        }
        
        todoListViewModel.updateToDoList(by: ToDoFilter(rawValue: todoFilterSC.selectedSegmentIndex) ?? .Today)
        
        updateUI()
    }
    
    private func updateUI()
    {
        noDataView.isHidden = todoListViewModel.numberOfRows() != 0
        editingModeNavBarBtn.isEnabled = todoListViewModel.numberOfRows() != 0
        editingModeNavBarBtn.isSelected = false
        tableView.isEditing = false
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK:- IBActions
    @IBAction func todoFilterSCAction(_ sender: UISegmentedControl)
    {
        reloadList(isReloadVM: false)
    }
    
    @IBAction func editingModeNavBarBtnAction(_ sender: UIBarButtonItem)
    {
        sender.isSelected = !sender.isSelected
        tableView.isEditing = sender.isSelected
    }
}

extension TodoListViewController
{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todoListViewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as! ToDoListTableViewCell
        cell.configure(todoListViewModel.modelAt(indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.tag = indexPath.row
        performSegue(withIdentifier: "AddToDoViewController", sender: tableView)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete, let safePrimaryKey = todoListViewModel.modelAt(indexPath.row).primaryKey
        {
            ManageToDoViewModel.shared.deleteToDoItem(for: safePrimaryKey) { Status in
                self.reloadList()
            }
        }
    }
}

extension TodoListViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddToDoViewController"
        {
            if let sender = sender as? UITableView
            {
                prepareSegueForAddToDoViewController(segue: segue, isEditing: true, selectedIndex: sender.tag)
            }
            else
            {
                prepareSegueForAddToDoViewController(segue: segue)
            }
        }
    }
    
    func prepareSegueForAddToDoViewController(segue: UIStoryboardSegue, isEditing: Bool = false, selectedIndex: Int = 0)
    {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found")
        }
        
        guard let addToDoVC = nav.viewControllers.first as? AddToDoViewController else {
            fatalError("AddToDoViewController not found")
        }
        
        addToDoVC.delegate = self
        
        if isEditing
        {
            addToDoVC.editingToDoViewModel = todoListViewModel.modelAt(selectedIndex)
        }
    }
}

extension TodoListViewController: AddToDoDelegate
{
    func addToDoDidSave(_ eventFilterType: ToDoFilter)
    {
        todoFilterSC.selectedSegmentIndex = eventFilterType.rawValue
        reloadList()
    }
    
}
