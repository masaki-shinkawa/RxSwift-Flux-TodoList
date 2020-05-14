//
//  TodoRequest.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RealmSwift

class TodoRequest: Object {
    static func add(parameter: TodoAddItemParameter) -> TodoItem {
        return TodoItem(title: parameter.title)
    }
}
