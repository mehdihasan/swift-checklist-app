//
//  AdditemTableViewController.swift
//  MyChekListApp
//
//  Created by Mehdi Hasan on 15/8/18.
//  Copyright © 2018 MehdiHasan. All rights reserved.
//

import UIKit

class AdditemTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }

    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done() {
        navigationController?.popViewController(animated: true)
    }
}
