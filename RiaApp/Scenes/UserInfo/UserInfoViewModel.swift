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
        case updateFirstNumber
    }
    
    struct State: AnyState {
        static func == (lhs: UserInfoViewModel.State, rhs: UserInfoViewModel.State) -> Bool {
            true
        }
        
        enum Screen: Equatable {
            case showCommentsScreen
        }
        //Screen
        public fileprivate(set) var showedScreen: Screen?
       
        
        init() {}
        
    }
    
    override func action(_ action: Action) {
        switch action {
        case let .updateFirstNumber:
          break
        }
    }
    
}
