//
//  Item.swift
//  TaskManager
//
//  Created by Rohith Raju on 24/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

import UIKit

class Item: Encodable, Decodable {

    var title: String!
    var done: Bool
    
    init() {
        self.done = false
    }
    
    convenience init(title: String) {
        
        self.init()
        
        self.title = title
        
    }
    
}
