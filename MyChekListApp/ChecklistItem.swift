//
//  ChecklistItem.swift
//  MyChekListApp
//
//  Created by Mehdi Hasan on 21/7/18.
//  Copyright © 2018 MehdiHasan. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    
    override var description: String {
        return """
        title: \(title),
        isDone: \(isDone)
        \n
        """
    }
    
    var title = ""
    var isDone = false
    
    func toggleDone() {
        isDone = !isDone
    }
    
    init(_ title: String, _ isDone: Bool) {
        self.title = title
        self.isDone = isDone
    }
}
