//
//  UserInfoViewModel.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import Combine
import SwiftUI
import SDWebImageSwiftUI

class UserInfoViewModel: BaseViewModel<UserInfoViewModel.State, UserInfoViewModel.Action, Never> {
    
    @StateObject var realmManager = RealmManager()
    
    enum Action {
        case updateUserInfo(UserInfo)
        case popupDidDisappear
        case saveOrDeleteUser
    }
    
    struct State: AnyState {
        static func == (lhs: UserInfoViewModel.State, rhs: UserInfoViewModel.State) -> Bool {
            true
        }
        
        enum Screen: Equatable {
            case back
        }
        //Screen
        public fileprivate(set) var showedScreen: Screen?
        //User
        public fileprivate(set) var usersInfo: UserInfo!
        public fileprivate(set) var showSaveUser: Bool = false
        
        init() {}
        
    }
    
    override func action(_ action: Action) {
        switch action {
        case let .updateUserInfo(user):
            state.usersInfo = user
        case .popupDidDisappear:
            state.showedScreen = nil
            state.showedScreen = .back
        case .saveOrDeleteUser:
            state.showedScreen = nil
            if state.showSaveUser == true {
                self.realmManager.deleteUser(name: "\(state.usersInfo.name.first + " " + state.usersInfo.name.last)")
                self.state.showSaveUser = false
            } else {
                self.realmManager.saveImage(user: state.usersInfo, image: state.usersInfo.picture.medium)
                self.state.showSaveUser = true
            }
        }
    }
    
    //Realm Save Persons
    func checkSavedPerson() {
        let persons = realmManager.users
        if (persons.first(where: { $0.name == "\(state.usersInfo.name.first + " " + state.usersInfo.name.last)"}) != nil) {
            state.showSaveUser = true
        } else {
            state.showSaveUser = false
        }
    }
}
