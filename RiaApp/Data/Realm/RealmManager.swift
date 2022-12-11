//
//  File.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    var localRealm: Realm?
    @Published var users: [UsersRealm] = []
    
    init() {
        openRealm()
        getUsers()
    }
    
    func openRealm() {
        do {
            let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
            }
            Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1, migrationBlock: migrationBlock)
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error.localizedDescription)
        }
    }
    
    func getUsers() {
        if let localRealm = localRealm {
            let allUsers = localRealm.objects(UsersRealm.self)
            users = []
            
            for person in allUsers {
                users.append(person)
            }
        }
        users.sort(by: { $0.name > $1.name })
    }
    
    func updateUser(user: UsersRealm, name: String, image: String, phone: String, email: String, country: String, city: String, street: String, number: String) {
        if let localRealm = localRealm {
            let person = UsersRealm(value: [ "id": user.id,
                                             "name": name,
                                             "image": image,
                                             "phone": phone,
                                             "email": email,
                                             "country": country,
                                             "city": city,
                                             "street": street,
                                             "number": number
                                           ])
            do {
                try localRealm.write {
                    localRealm.add(person, update: .modified)
                    getUsers()
                }
            } catch {
                print("Error adding user to : \(error)")
            }
        }
    }
    
    func addUser(name: String, image: String, phone: String, email: String, country: String, city: String, street: String, number: String) {
        if let localRealm = localRealm {
            let person = UsersRealm(value: [  "name": name,
                                              "image": image,
                                              "phone": phone,
                                              "email": email,
                                              "country": country,
                                              "city": city,
                                              "street": street,
                                              "number": number
                                           ])
            
            let result = users.contains { $0 == person }
            
            if result {
                print("User exist")
            } else {
                do {
                    try localRealm.write {
                        localRealm.add(person)
                        getUsers()
                    }
                } catch {
                    print("Error adding user to : \(error)")
                }
            }
        }
    }
    
    func deleteUser(name: String) {
        if let localRealm = localRealm {
            do {
                let userToDelete = localRealm.objects(UsersRealm.self).first(where: {$0.name == name })
                
                guard userToDelete != nil else {return}
                
                try localRealm.write {
                    localRealm.delete(userToDelete!)
                    getUsers()
                }
            } catch {
                print("\(error)")
            }
        }
    }
    
    func saveImage(user: UserInfo, image: String) {
        if let url = URL(string: image) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    let saveImage = FileHelper().saveImage(data: imageData)
                    self.addUser(name: "\(user.name.first + " " + user.name.last)", image: saveImage!, phone: user.phone, email: user.email, country: user.location.country, city: user.location.city, street: user.location.street.name, number: String(user.location.street.number))
                }
            }.resume()
        }
    }
}
