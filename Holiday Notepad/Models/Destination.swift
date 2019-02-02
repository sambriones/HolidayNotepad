//
//  Destination.swift
//  Holiday Notepad
//
//  Created by Jessamine Briones on 2/2/19.
//  Copyright © 2019 Jessamine Briones. All rights reserved.
//

import UIKit
import RealmSwift

class Destination: Object {
    @objc dynamic var cityName: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()

}
