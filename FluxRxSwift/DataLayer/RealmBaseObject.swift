//
//  RealmBaseObject.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/15.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmBaseObjectProtocol {
    func insert() -> Object?
    func select() -> [Object]?
}

public class RealmBaseObject: Object, RealmBaseObjectProtocol {
    func insert() -> Object? {
        guard let realm = createRealm() else {
            return nil
        }

        do {
            try realm.write({
                realm.add(self, update: .all)
            })
            return self
        } catch {
            return nil
        }
    }

    func select() -> [Object]? {
        return nil
    }

    func getRealmConfig() -> Realm.Configuration {
        return Realm.Configuration(schemaVersion: 2)
    }

    func createRealm() -> Realm? {
        do {
            return try Realm(configuration: RealmClient.getRealmConfig())
        } catch {
            return nil
        }
    }

}
