//
//  UserInfoViewModel.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import Combine
import SwiftUI

class UserInfoViewModel: BaseViewModel<UserInfoViewModel.State, UserInfoViewModel.Action, Never> {
    
    enum Action {
        case updateUserInfo(UserInfo)
        case popupDidDisappear
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
        
        init() {}
        
    }
    
    override func action(_ action: Action) {
        switch action {
        case let .updateUserInfo(user):
            state.usersInfo = user
        case .popupDidDisappear:
            state.showedScreen = nil
            state.showedScreen = .back
        }
    }
    
}
