//
//  SaveUsers.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

extension SaveUsersViewController {
    
    struct ContainerView: View {
        
        @ObservedObject var viewModel: ViewModel
        @StateObject var realmManager = RealmManager()
        
        init(_ viewModel: ViewModel) {
            self._viewModel = .init(initialValue: viewModel)
        }
        
        public var body: some View {
            VStack {
                navBar
                listComments
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [.blue, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(0))
                    .edgesIgnoringSafeArea(.all)
            )
        }
        
        //NavBar
        private var navBar: some View {
            CustomNavBar {
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
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
        }
        
        //List Comments
        private var listComments: some View {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(realmManager.users, id: \.id) { user in
                        userRow(user)
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
        
        func userRow(_ user: UsersRealm) -> some View {
          return HStack {
                  Image(uiImage: viewModel.loadImage(fileName: user.image)!)
                      .resizable()
                      .scaledToFit()
                      .frame(width: 80, height: 80)
                      .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 6, content: {
                  Text(user.name)
                  Text(user.phone)
            })
            .bold()
            .foregroundColor(Color.black)
            .font(.caption)
            Spacer()
              Button {
                  realmManager.deleteUser(name: user.name)
              } label: {
                  Image(systemName: "minus.circle")
                      .foregroundColor(Color.red)
              }
              .padding(.trailing, 5)
          }
        }
    }
}

