//
//  UserInfoView.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

extension UserInfoViewController {
    
    struct ContainerView: View {
        
        @ObservedObject var viewModel: ViewModel
        
        init(_ viewModel: ViewModel) {
            self._viewModel = .init(initialValue: viewModel)
        }
        
        public var body: some View {
            VStack {
                navBar
                userInfo
                Spacer()
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
                Text("UserInfo")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                
            } right: {
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
        }
        
        //UserInfo
        private var userInfo: some View {
            VStack {
                WebImage(url: URL(string: viewModel.state.usersInfo.picture.medium))
                  .resizable()
                  .scaledToFit()
                  .frame(width: 80, height: 80)
                  .clipShape(Circle())
                HStack {
                    Text(viewModel.state.usersInfo.name.first)
                    Text(viewModel.state.usersInfo.name.last)
                }
                Text(viewModel.state.usersInfo.phone)
                Text(viewModel.state.usersInfo.email)
                VStack {
                    Text(viewModel.state.usersInfo.location.country)
                    Text(viewModel.state.usersInfo.location.city)
                    Text(viewModel.state.usersInfo.location.street.name)
                    Text(viewModel.state.usersInfo.location.street.number.description)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
        }
    }
}

