//
//  Item.swift
//  Holiday Notepad
//
//  Created by Jessamine Briones on 2/2/19.
//  Copyright © 2019 Jessamine Briones. All rights reserved.
//

import UIKit
import RealmSwift


class Item: Object {
    
    @objc dynamic var done : Bool = false
    @objc dynamic var title : String = ""
    @objc dynamic var type : Int = 0
    
    var parentCategory = LinkingObjects(fromType: Destination.self, property: "items")

}
