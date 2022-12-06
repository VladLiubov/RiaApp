//
//  UserInfoView.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import SwiftUI
import Combine

extension UserInfoViewController {
    
    struct ContainerView: View {
        
        @ObservedObject var viewModel: ViewModel
        
        init(_ viewModel: ViewModel) {
            self._viewModel = .init(initialValue: viewModel)
        }
        
        public var body: some View {
            
            Text("")
        }
    }
}

