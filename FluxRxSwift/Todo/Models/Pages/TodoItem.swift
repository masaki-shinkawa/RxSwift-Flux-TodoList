//
//  TodoItem.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RealmSwift

public class TodoItem: RealmBaseObject {
    @objc dynamic var id: String?
    @objc dynamic var title: String?
    @objc dynamic var createdAt: Date?
    @objc dynamic var updatedAt: Date?

    convenience init (
        title: String?
    ) {
        self.init()
        self.id = NSUUID().uuidString
        self.title = title
        self.createdAt = Date()
        self.updatedAt = Date()
    }

    convenience init (
        id: String?,
        title: String?,
        createdAt: Date?,
        updatedAt: Date?
    ) {
        self.init()
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    required init() { }
    func select() -> [TodoItem]? {
        guard let realm = self.createRealm() else {
            return nil
        }
        return Array(realm.objects(TodoItem.self))
    }
    public override class func primaryKey() -> String? {
        return "id"
    }
}
