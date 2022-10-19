//
//  Item.swift
//  Todo-app
//
//  Created by Infinity Code on 10/18/22.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?

    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
