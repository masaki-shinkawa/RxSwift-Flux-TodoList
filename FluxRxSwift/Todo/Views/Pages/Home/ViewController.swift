//
//  ViewController.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/11.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var todoTableView: UITableView!

    let disposeBag = DisposeBag()
    fileprivate var index: ItemListIndexProtocol?

    var todos = [TodoItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        index = ItemListIndex()
        index?.action.show()
        index?.store
            .itemList
            .asDriver()
            .skip(0)
            .drive(
                onNext: { [weak self] data, error in
                    guard let data = data, error == nil else { return }
                    self?.updateView(data: data)
                }
        ).disposed(by: disposeBag)

        addButton.rx.tap.subscribe { [unowned self] _ in
            self.index?.action.add(title: self.todoTextField.text ?? "")
        }.disposed(by: disposeBag)
    }

    private func updateView(data: ItemListState) {
        print("** reload view **")
        print(data)
        print("")
        todos = data.itemList
        todoTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TodoTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TodoTableViewCell else {
            fatalError("The dequeued cell is not an instance of TodoTableViewCell.")
        }

        cell.todoLabel.text = todos[indexPath.row].title

        return cell
    }
}
