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
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            localRealm = try? Realm()
            
        } catch {
            print("Error opening Realm", error.localizedDescription)
        }
    }
    
    func getUsers() -> [UsersRealm] {
        if let localRealm = localRealm {
            let allUsers = localRealm.objects(UsersRealm.self)
            users = []
            
            for person in allUsers {
                users.append(person)
            }
        }
        return users
    }
    
    func addUser(user: UserInfo, image: String) {
        if let localRealm = localRealm {
            let person = UsersRealm(value: [  "name": "\(user.name.first + " " + user.name.last)",
                                                 "image": image,
                                                 "phone": user.phone,
                                                 "email": user.email,
                                                 "city": user.location.city,
                                                 "street": user.location.street.name,
                                                 "number": String(user.location.street.number)
                                                ])
            
            let result = users.contains { $0 == person }
            
            if result {
                print("User exist")
            } else {
                do {
                    try localRealm.write {
                        localRealm.add(person)
                        print("Added: \(person)")
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
                let personToDelete = localRealm.objects(UsersRealm.self).first(where: {$0.name == name })
                
                guard personToDelete != nil else {return}
                
                try localRealm.write {
                    localRealm.delete(personToDelete!)
                    getUsers()
                }
            } catch {
                print("\(error)")
            }
        }
    }
    
    func saveImage(user: UserInfo, image: String) {
        
        let data = try? Data(contentsOf: URL(string: image)!)
        let newImage = UIImage(data: data!)

     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = UUID().uuidString
        let fileURL = documentsDirectory.appendingPathComponent("\(fileName).jpg")
        guard let data = newImage?.jpegData(compressionQuality: 1) else { return }

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }

        do {
            let nameImage = save(image: newImage!, filename: "\(fileName).jpg")!
            addUser(user: user, image: nameImage)
        } catch let error {
            print("error saving file with error", error)
        }

    }
    
    private func save(image: UIImage, filename: String) -> String? {
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        let fileURL = documentsUrl.appendingPathComponent(filename)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
           try? imageData.write(to: fileURL, options: .atomic)
           return filename // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }

}
