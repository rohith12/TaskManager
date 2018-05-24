//
//  Item.swift
//  TaskManager
//
//  Created by Rohith Raju on 24/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

import UIKit

class Item: Encodable, Decodable {

    let title: String
    var done: Bool
    
    init(title: String) {
        
        self.title = title
        self.done = false
        
    }
    
}
