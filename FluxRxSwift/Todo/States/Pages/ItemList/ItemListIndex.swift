//
//  ItemListIndex.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation

protocol ItemListIndexProtocol {
    var action: TodoActionProtocol {get}
    var store: TodoStoreProtocol {get}
}

final class ItemListIndex: ItemListIndexProtocol {
    private(set) var action: TodoActionProtocol
    private(set) var store: TodoStoreProtocol

    init() {
        let dispatcher = TodoDispatcher.shared
        let repository = TodoRepository()

        store = TodoStore.shared
        action = ItemListActionCreator(repository: repository, dispatcher: dispatcher)
    }
}
