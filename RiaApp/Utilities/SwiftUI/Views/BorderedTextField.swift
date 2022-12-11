//
//  BorderedTextField.swift
//  RiaApp
//
//  Created by Admin on 11.12.2022.
//

import SwiftUI

public struct BorderedTextField: View {
    @Binding var text: String
    @State var placeholder: String
    @State var KeyboardType: UIKit.UIKeyboardType?
    @State var color: Color?
    @State var showIconStarNecessary: Bool
    var isValid: Bool?
    @Environment(\.colorScheme) private var colorScheme
    
    public var body: some View {
        VStack {
            ZStack {
                HStack {
                    TextField("", text: $text)
                        .keyboardType(self.KeyboardType!)
                        .overlay(
                            HStack{
                                Spacer()
                                if !$text.wrappedValue.isEmpty {
                                    Button(action: {$text.wrappedValue = ""}) {
                                        Image(systemName: "xmark.circle.fill")
                                            .padding(.vertical)
                                    }
                                }
                            }
                                .foregroundColor(Color.gray)
                        )
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .foregroundColor(Color.blue)
                        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                    HStack(spacing: 0) {
                        Text(placeholder)
                            .foregroundColor(color ?? Color.blue)
                            .background(color ?? Color(UIColor.white))
                        if showIconStarNecessary{
                            Text("*")
                                .foregroundColor(Color.red)
                                .background(color ?? Color(UIColor.white))
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 68, maxHeight: 68, alignment: .topLeading)
                    .padding(.leading, 20)
                    .padding(.horizontal, 5)
                }
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48)
            }
            if !(isValid ?? true) {
                VStack {
                    HStack {
                        Text("Name must contain more than three characters")
                            .font(.caption2)
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 98, maxHeight: 98)
    }
}
