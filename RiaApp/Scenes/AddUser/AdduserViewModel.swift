//
//  AdduserViewModel.swift
//  RiaApp
//
//  Created by Admin on 11.12.2022.
//

import Combine
import SwiftUI
import RealmSwift

class AddUserViewModel: BaseViewModel<AddUserViewModel.State, AddUserViewModel.Action, Never> {
    
    @ObservedObject var realmManager = RealmManager()
    
    enum Action {
        //Main
        case popupDidDisappear
        case addUser
        //Photo
        case updateSelectedImage(UIImage)
        case updateImagePickerInput(Bool)
        case saveImage(UIImage)
        //TexFields
        case updateName(String)
        case updatePhone(String)
        case updateEmail(String)
        case updateCountry(String)
        case updateCity(String)
        case updateStreet(String)
        case updateNumber(String)
    }
    
    struct State: AnyState {
        
        enum Screen: Equatable {
            case back
        }
        
        //Screen
        public fileprivate(set) var showedScreen: Screen?
        public fileprivate(set) var showFormErrors: Bool = false
        public fileprivate(set) var showKeyboard: Bool = false
        public fileprivate(set) var isNameValid: Bool = false
        //User
        public fileprivate(set) var user: UsersRealm?
        //Photo
        public fileprivate(set) var selectedImage: UIImage?
        public fileprivate(set) var imagePicker: Bool = false
        //TextFields
        public fileprivate(set) var name: String = ""
        public fileprivate(set) var phone: String = ""
        public fileprivate(set) var image: String = ""
        public fileprivate(set) var email: String = ""
        public fileprivate(set) var country: String = ""
        public fileprivate(set) var city: String = ""
        public fileprivate(set) var street: String = ""
        public fileprivate(set) var number: String = ""
        
        init() {}
        
    }
    
    override func action(_ action: Action) {
        switch action {
            //Main
        case .popupDidDisappear:
            state.showedScreen = nil
            state.showedScreen = .back
        case let .saveImage(image):
            if let data = image.pngData() {
                state.image = FileHelper().saveImage(data: data)!
            }
        case .addUser:
            if state.isNameValid {
                realmManager.addUser(name: state.name, image: state.image, phone: state.phone, email: state.email, country: state.country, city: state.city, street: state.street, number: state.number)
                state.showedScreen = nil
                state.showedScreen = .back
            }
            //Image
        case let .updateSelectedImage(image):
            state.selectedImage = image
        case let .updateImagePickerInput(bool):
            state.imagePicker = bool
            //TextFields
        case let .updateName(name) where name != state.name:
            state.showKeyboard = true
            state.name = name
            if name.count < 3 { state.isNameValid = false } else { state.isNameValid = true }
        case let .updatePhone(phone) where phone != state.phone:
            state.showKeyboard = true
            state.phone = phone
        case let .updateEmail(email) where email != state.email:
            state.showKeyboard = true
            state.email = email
        case let .updateCountry(country) where country != state.country:
            state.showKeyboard = true
            state.country = country
        case let .updateCity(city) where city != state.city:
            state.showKeyboard = true
            state.city = city
        case let .updateStreet(street) where street != state.street:
            state.showKeyboard = true
            state.street = street
        case let .updateNumber(number) where number != state.number:
            state.showKeyboard = true
            state.number = number
        case .updateName, .updatePhone, .updateEmail, .updateCountry,
                .updateCity, .updateStreet, .updateNumber:
            break
        }
    }
}
