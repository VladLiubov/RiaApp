//
//  UserInfoView.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

extension UsersListViewController {
    
    struct ContainerView: View {
        
        @ObservedObject var viewModel: ViewModel
        
        init(_ viewModel: ViewModel) {
            self._viewModel = .init(initialValue: viewModel)
            viewModel.getUsersList()
        }
        
        public var body: some View {
            VStack {
                navBar
                listUsers
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        
        //NavBar
        private var navBar: some View {
            CustomNavBar {
                
            } center: {
                Text("Users")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                
            } right: {
                Button {
                    viewModel.action(.showSaveUsers)
                } label: {
                    Image(systemName: "list.bullet.rectangle.portrait")
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
        }
        
        //List Users
        private var listUsers: some View {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.state.usersList, id: \.self) { user in
                        userRow(user)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity,
                                alignment: .topLeading
                            )
                            .background(Color.clear)
                            .onTapGesture {
                                viewModel.action(.showUserInfo(user))
                            }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        
        func userRow(_ user: UserInfo) -> some View {
            return HStack {
                WebImage(url: URL(string:user.picture.medium))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 6, content: {
                    Text(user.name.first + " " + user.name.last)
                        .font(.headline)
                    Text(user.phone)
                        .font(.caption2)
                })
                .bold()
                .font(.caption)
            }
        }
    }
}
