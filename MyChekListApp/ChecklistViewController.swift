//
//  ViewController.swift
//  MyChekListApp
//
//  Created by Mehdi Hasan on 20/7/18.
//  Copyright © 2018 MehdiHasan. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailDeligate {
    
    func itemDetailViewControllerDidCancel(_ viewController: UIViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ viewController: UIViewController, didFinishAdding item: ChecklistItem) {
        addNewChecklistItem(item: item)
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ viewController: UIViewController, didFinishEditing item: ChecklistItem) {
        if let index = rows.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, item: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    var rows: [ChecklistItem] = [ChecklistItem]()
    
    required init?(coder aDecoder: NSCoder) {
        let row0item = ChecklistItem("Walk the dog", false)
        let row1item = ChecklistItem("Brush my teeth", false)
        let row2item = ChecklistItem("Learn iOS development", false)
        let row3item = ChecklistItem("Soccer practice", false)
        let row4item = ChecklistItem("Eat ice cream", false)
        rows = [row0item, row1item, row2item, row3item, row4item]
        super.init(coder: aDecoder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddItem") {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        }
        else if (segue.identifier == "EditItem") {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.checkListItem = rows[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        rows.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = rows[indexPath.row]
            item.toggleDone()
            configureCheckmark(for: cell, item: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        
        let item = rows[indexPath.row]
        configureText(for: cell, item: item)
        configureCheckmark(for: cell, item: item)
        
        return cell
    }
    
    func addNewChecklistItem(item: ChecklistItem) {
        let newRowIndex = rows.count
        rows.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func configureText(for cell: UITableViewCell, item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = item.title
    }
    
    func configureCheckmark(for cell: UITableViewCell, item: ChecklistItem) {
        let label = cell.viewWithTag(1002) as! UILabel
        if (item.isDone) {
            label.text = "√"
        } else {
            label.text = ""
        }
        // print(rows)
    }
}
