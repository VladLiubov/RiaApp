//
//  ModelRealm.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import Foundation
import RealmSwift


class UsersRealm: Object, ObjectKeyIdentifiable {
    @Persisted (primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var image = ""
    @Persisted var phone = ""
    @Persisted var email = ""
    @Persisted var country = ""
    @Persisted var city = ""
    @Persisted var street = ""
    @Persisted var number = ""
}
