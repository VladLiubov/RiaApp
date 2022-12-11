//
//  SaveUsers.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI
import RealmSwift

extension SaveUsersViewController {
    
    struct ContainerView: View {
        
        @ObservedObject var viewModel: ViewModel
        @ObservedResults(UsersRealm.self) var users
        
        init(_ viewModel: ViewModel) {
            self._viewModel = .init(initialValue: viewModel)
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
            return CustomNavBar {
                Button {
                    viewModel.action(.popupDidDisappear)
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.orange)
                }
            } center: {
                Text("SaveUsers")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                
            } right: {
                Button {
                    withAnimation {
                        viewModel.action(.addUser)
                    }
                } label: {
                    Text("Add")
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
        }
        
        //List Users
        private var listUsers: some View {
            return ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(users, id: \.self) { user in
                        VStack {
                            HStack {
                                if !user.image.isEmpty {
                                    Image(uiImage: FileHelper().loadImage(fileName: user.image)!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                } else {
                                    Image("")
                                        .resizable()
                                        .scaledToFill()
                                        .background(Color.gray)
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                }
                                
                                Text(user.name)
                                    .bold()
                                    .font(.title3)
                                
                                Button {
                                    viewModel.action(.editUser(user))
                                } label: {
                                    Image(systemName: "highlighter")
                                        .foregroundColor(Color.gray)
                                }
                                .padding(.trailing, 10)
                                Spacer()
                            }
                            HStack {
                                Divider()
                                    .frame(width: 4)
                                    .overlay(.purple.opacity(0.6))
                                    .cornerRadius(16)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    if !user.phone.isEmpty {
                                        HStack {
                                            Text("Phone:")
                                            Text(user.phone)
                                            Spacer()
                                        }
                                    }
                                    if user.email != "" {
                                        HStack {
                                            Text("Email:")
                                            Text(user.email)
                                            Spacer()
                                        }
                                    }
                                    if user.country != "" {
                                        HStack {
                                            Text("Country:")
                                            Text(user.country)
                                            Spacer()
                                        }
                                    }
                                    if user.city != "" {
                                        HStack {
                                            Text("City:")
                                            Text(user.city)
                                            Spacer()
                                        }
                                    }
                                    if user.street != "" {
                                        HStack {
                                            Text("Street:")
                                            Text(user.street)
                                            Spacer()
                                        }
                                    }
                                    if user.number != "" {
                                        HStack {
                                            Text("Number:")
                                            Text(user.number)
                                            Spacer()
                                        }
                                    }
                                }
                                .padding()
                                .bold()
                                .font(.caption)
                                .background(Color.purple.opacity(0.2))
                                .cornerRadius(12)
                            }
                        }
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                        .background(Color.clear)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

