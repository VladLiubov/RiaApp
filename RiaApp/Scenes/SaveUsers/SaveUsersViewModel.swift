//
//  SaveUsersViewModel.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import Combine
import SwiftUI
import RealmSwift

class SaveUsersViewModel: BaseViewModel<SaveUsersViewModel.State, SaveUsersViewModel.Action, Never> {
    
    @ObservedObject var realmManager = RealmManager()
    
    enum Action {
        case popupDidDisappear
        case editUser(UsersRealm)
        case addUser
    }
    
    struct State: AnyState {
        static func == (lhs: SaveUsersViewModel.State, rhs: SaveUsersViewModel.State) -> Bool {
            true
        }
        
        enum Screen: Equatable {
            case back
            case editeUserScreen
            case addUserScreen
        }
        
        //Screen
        public fileprivate(set) var showedScreen: Screen?
        //User
        public fileprivate(set) var usersInfo: UserInfo?
        //Edit
        public fileprivate(set) var editUser: UsersRealm?
        
        init() {}
        
    }
    
    override func action(_ action: Action) {
        switch action {
        case .popupDidDisappear:
            state.showedScreen = nil
            state.showedScreen = .back
        case let .editUser(user):
            state.showedScreen = nil
            state.editUser = user
            state.showedScreen = .editeUserScreen
        case .addUser:
            state.showedScreen = nil
            state.showedScreen = .addUserScreen
        }
    }
}
