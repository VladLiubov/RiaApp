//
//  AddUserView.swift
//  RiaApp
//
//  Created by Admin on 11.12.2022.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI
import RealmSwift
import Photos

extension AddUserViewController {
    
    struct ContainerView: View {
        
        @ObservedObject var viewModel: ViewModel
        @State var selectedImage: UIImage?
        
        init(_ viewModel: ViewModel) {
            self._viewModel = .init(initialValue: viewModel)
        }
        
        public var body: some View {
            
            VStack(alignment: .center) {
                navBar
                editUser
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        
        //MARK: - NavBar
        private var navBar: some View {
            return CustomNavBar {
                Button {
                    viewModel.action(.popupDidDisappear)
                } label: {
                    Text("Cancel")
                        .foregroundColor(.orange)
                }
            } center: {
                Text("AddUser")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                
            } right: {
                Button {
                    viewModel.action(.addUser)
                } label: {
                    Text("Save")
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
        }
        
        //MARK: - EditUser
        private var editUser: some View {
            GeometryReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollViewReader { scrollView in
                        VStack(alignment: .center) {
                            userPhoto
                            nameTextField
                            phoneTextField
                            emailTextField
                            countryTextField
                            cityTextField
                            streetTextField
                            numberTextField
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
        
        //MARK: - Photo
        private var userPhoto: some View {
            
            let bindingShowImagePickerInput = Binding<Bool> (
                get: { viewModel.state.imagePicker },
                set: { viewModel.action(.updateImagePickerInput($0)) }
            )
            return VStack(alignment: .center) {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
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
                Button {
                    bindingShowImagePickerInput.wrappedValue = true
                } label: {
                    Text("Edit")
                }
                .sheet(isPresented: bindingShowImagePickerInput) {
                    ImagePickerView(selectedImage: $selectedImage)
                        .edgesIgnoringSafeArea(.bottom)
                }
                .onChange(of: selectedImage) { _ in
                    if selectedImage != nil { viewModel.action(.saveImage((selectedImage?.withHorizontallyFlippedOrientation())!)) }
                }
            }
            .padding([.top, .bottom], 10)
        }
        
        //MARK: - Name
        var nameTextField: some View {
            let nameBinding = Binding(
                get: { viewModel.state.name },
                set: { viewModel.action(.updateName($0)) }
            )
            
            let nameValidBinding = Binding(
                get: { viewModel.state.isNameValid },
                set: { _ in }
            )
            
            return BorderedTextField(text: nameBinding,
                                     placeholder: "Name",
                                     KeyboardType: .default,
                                     showIconStarNecessary: true,
                                     isValid: nameValidBinding.wrappedValue)
        }
        //MARK: - Phone
        var phoneTextField: some View {
            let phoneBinding = Binding(
                get: { viewModel.state.phone },
                set: { viewModel.action(.updatePhone($0)) }
            )
            return BorderedTextField(text: phoneBinding,
                                     placeholder: "Phone",
                                     KeyboardType: .numbersAndPunctuation,
                                     showIconStarNecessary: false)
        }
        //MARK: - Email
        var emailTextField: some View {
            let emailBinding = Binding(
                get: { viewModel.state.email },
                set: { viewModel.action(.updateEmail($0)) }
            )
            return BorderedTextField(text: emailBinding,
                                     placeholder: "Email",
                                     KeyboardType: .default,
                                     showIconStarNecessary: false)
        }
        //MARK: - Country
        var countryTextField: some View {
            let countryBinding = Binding(
                get: { viewModel.state.country },
                set: { viewModel.action(.updateCountry($0)) }
            )
            return BorderedTextField(text: countryBinding,
                                     placeholder: "Country",
                                     KeyboardType: .default,
                                     showIconStarNecessary: false)
        }
        //MARK: - City
        var cityTextField: some View {
            let cityBinding = Binding(
                get: { viewModel.state.city },
                set: { viewModel.action(.updateCity($0)) }
            )
            return BorderedTextField(text: cityBinding,
                                     placeholder: "City",
                                     KeyboardType: .default,
                                     showIconStarNecessary: false)
        }
        //MARK: - Street
        var streetTextField: some View {
            let streetBinding = Binding(
                get: { viewModel.state.street },
                set: { viewModel.action(.updateStreet($0)) }
            )
            return BorderedTextField(text: streetBinding,
                                     placeholder: "Street",
                                     KeyboardType: .default,
                                     showIconStarNecessary: false)
        }
        //MARK: - Number
        var numberTextField: some View {
            let numberBinding = Binding(
                get: { viewModel.state.number },
                set: { viewModel.action(.updateNumber($0)) }
            )
            return BorderedTextField(text: numberBinding,
                                     placeholder: "Number",
                                     KeyboardType: .numbersAndPunctuation,
                                     showIconStarNecessary: false)
        }
    }
}
