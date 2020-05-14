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

class ViewController: UIViewController {
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    let disposeBag = DisposeBag()
    var list = [String]()
    fileprivate var index: ItemListIndexProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        index = ItemListIndex()
        addButton.rx.tap.subscribe { [unowned self] _ in
            self.index?.action.add(title: self.todoTextField.text ?? "")
        }.disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
