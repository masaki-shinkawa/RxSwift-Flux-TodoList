//
//  ItemListState.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation

struct ItemListState {
    private(set) var itemList: [TodoItem]

    init(itemList: [TodoItem]) {
        self.itemList = itemList
    }
}
