//
//  ViewController.swift
//  MyChekListApp
//
//  Created by Mehdi Hasan on 20/7/18.
//  Copyright © 2018 MehdiHasan. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
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
    
    @IBAction func addNewChecklistItem() {
        
        let newRowIndex = rows.count
        
        let newCheckListItem = ChecklistItem("A new item", false)
        
        rows.append(newCheckListItem)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        print("Add new item")
    }
    
    func configureText(for cell: UITableViewCell, item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = item.title
    }
    
    func configureCheckmark(for cell: UITableViewCell, item: ChecklistItem) {
        if (item.isDone) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        print(rows)
    }
}

