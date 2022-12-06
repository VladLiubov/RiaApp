//
//  SaveUsersViewModel.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import Combine
import SwiftUI

class SaveUsersViewModel: BaseViewModel<SaveUsersViewModel.State, SaveUsersViewModel.Action, Never> {
    
    enum Action {
        case popupDidDisappear
    }
    
    struct State: AnyState {
        static func == (lhs: SaveUsersViewModel.State, rhs: SaveUsersViewModel.State) -> Bool {
            true
        }
        
        enum Screen: Equatable {
            case back
            case showUserInfoScreen
        }
        
        //Screen
        public fileprivate(set) var showedScreen: Screen?
        //User
        public fileprivate(set) var usersInfo: UserInfo?
        
        init() {}
        
    }
    
    override func action(_ action: Action) {
        switch action {
        case .popupDidDisappear:
            state.showedScreen = nil
            state.showedScreen = .back
        }
    }
    
    func loadImage(fileName: String) -> UIImage? {
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
}
