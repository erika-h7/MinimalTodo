//
//  Category.swift
//  Todo-app
//
//  Created by Infinity Code on 10/18/22.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
