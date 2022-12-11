//
//  UsewrListViewModel.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import Combine
import SwiftUI

class UsersListViewModel: BaseViewModel<UsersListViewModel.State, UsersListViewModel.Action, Never> {
    
    enum Action {
        case showUserInfo(UserInfo)
        case showSaveUsers
    }
    
    struct State: AnyState {
        static func == (lhs: UsersListViewModel.State, rhs: UsersListViewModel.State) -> Bool {
            true
        }
        
        enum Screen: Equatable {
            case showUserInfoScreen
            case showSaveUsersScreen
        }
        
        //Screen
        public fileprivate(set) var showedScreen: Screen?
        //Users
        public fileprivate(set) var usersList: [UserInfo] = []
        public fileprivate(set) var usersInfo: UserInfo?
        
        init() {}
        
    }
    
    override func action(_ action: Action) {
        switch action {
        case let .showUserInfo(user):
            state.showedScreen = nil
            state.usersInfo = user
            state.showedScreen = .showUserInfoScreen
        case .showSaveUsers:
            state.showedScreen = nil
            state.showedScreen = .showSaveUsersScreen
        }
    }
    
    func getUsersList() {
        UserService
            .usersList()
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case .finished:
                    return
                }
            } receiveValue: { [weak self] (users) in
                self?.state.usersList = users.results
            }
            .store(in: &cancellables)
    }
}
