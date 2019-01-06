//
//  AdditemTableViewController.swift
//  MyChekListApp
//
//  Created by Mehdi Hasan on 15/8/18.
//  Copyright © 2018 MehdiHasan. All rights reserved.
//

import UIKit

protocol ItemDetailDeligate: class {
    func itemDetailViewControllerDidCancel(_ viewController: UIViewController)
    func itemDetailViewController(_ viewController: UIViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ viewController: UIViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var checkListItem: ChecklistItem?
    
    weak var delegate: ItemDetailDeligate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let item = checkListItem {
            title = "Edit Item"
            textField.text = item.title
            doneButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }

    @IBAction func cancel() {
        // navigationController?.popViewController(animated: true)
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        // navigationController?.popViewController(animated: true)
        
        if let item = checkListItem {
            if let title = textField?.text {
                item.title = title
                delegate?.itemDetailViewController(self, didFinishEditing: item)
            }
            
            delegate?.itemDetailViewControllerDidCancel(self)
            
        } else {
            let item = ChecklistItem((textField?.text)!, false)
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        
        print("NEW TEXT \(newText)")
        
        if newText.isEmpty {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneButton.isEnabled = false
        return true
    }
}
