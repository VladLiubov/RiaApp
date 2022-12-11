//
//  UserInfoView.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI
import MapKit

extension UserInfoViewController {
    
    struct ContainerView: View {
        
        @ObservedObject var viewModel: ViewModel
        
        @State var showFullPhoto: Bool = false
        
        init(_ viewModel: ViewModel) {
            self._viewModel = .init(initialValue: viewModel)
            viewModel.checkSavedUser()
        }
        
        public var body: some View {
            VStack {
                navBar
                ScrollView(.vertical, showsIndicators: false) {
                    userInfo
                    Spacer()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
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
                Button {
                    viewModel.action(.saveOrDeleteUser)
                } label: {
                    Image(systemName: viewModel.state.showSaveUser ? "square.and.arrow.down.fill" : "square.and.arrow.down")
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
        }
        
        //UserInfo
        private var userInfo: some View {
            
            let bindingRegion = Binding (
                get: { viewModel.state.mapInfo.region},
                set: { _ in }
            )
            
            return VStack {
                if showFullPhoto == false {
                    WebImage(url: URL(string: viewModel.state.usersInfo.picture.medium))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showFullPhoto.toggle()
                            }
                        }
                } else {
                    ZStack(alignment: .center) {
                        Color.gray
                            .ignoresSafeArea(.all)
                            .onTapGesture {
                                showFullPhoto.toggle()
                            }
                        WebImage(url: URL(string: viewModel.state.usersInfo.picture.large))
                            .resizable()
                            .scaledToFill()
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    showFullPhoto.toggle()
                                }
                            }
                            .ignoresSafeArea(.all)
                    }
                }
                VStack {
                    HStack {
                        Text(viewModel.state.usersInfo.name.first)
                        Text(viewModel.state.usersInfo.name.last)
                    }
                    Text(viewModel.state.usersInfo.phone)
                    Text(viewModel.state.usersInfo.email)
                    Text(viewModel.state.usersInfo.location.country)
                    Text(viewModel.state.usersInfo.location.city)
                    Text(viewModel.state.usersInfo.location.street.name)
                    Text(viewModel.state.usersInfo.location.street.number.description)
                }
                
                Map(coordinateRegion: bindingRegion, annotationItems: viewModel.state.mapInfo.location) { location in
                    MapMarker(coordinate: location.coordinate)
                }
                .frame(height: 300)
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
        }
    }
}


