//
//  TodoStore.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TodoStoreProtocol {
    var itemList: BehaviorRelay<(ItemListState?, AppError?)> {get}
}

class TodoStore: TodoStoreProtocol {

    static var shared = TodoStore()
    private(set) var itemList = BehaviorRelay<(ItemListState?, AppError?)>(value: (nil, nil))
    private let disposeBag = DisposeBag()

    init(dispatcher: TodoDispatcher = .shared) {
        dispatcher.action
            .subscribe(
                onNext: { [weak self] action in
                    self?.reducer(action: action, state: .shared)
                }
        ).disposed(by: disposeBag)
    }

    deinit { }
}

private extension TodoStore {
    func reducer(action: Action, state: TodoStore) {
        switch action {
        case let action as TodoActions.AddTodo:
            var prevItemList = state.itemList.value.0?.itemList ?? []
            prevItemList.append(action.todoItem)
            let item = ItemListState(itemList: prevItemList)
            state.itemList.accept((item, nil))
            print(state.itemList.value.0?.itemList)
        default:
            break
        }
    }
}
