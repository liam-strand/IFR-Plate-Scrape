//
//  SearchBarView.swift
//  swiftuitesting
//
//  Created by Liam Strand on 8/26/21.
//

import SwiftUI

struct SearchBarView: View {
    
    let requestManager = RequestManager()
    
    @Binding var text: String
    
    @Binding var plates: [Plate]
    
    @Binding var isPresented: Bool
    
    @State private var isEditing = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                TextField("Search", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(7)
                    .padding(.horizontal, 25)
                    .frame(width: 200, height: 40)
                    .autocapitalization(.allCharacters)
                    .disableAutocorrection(true)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing {
                                Button(action: {
                                    text = ""
                                }, label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                
                                })
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        isEditing = true
                        print(isPresented)
                    }
            }
            
            HStack {
                Button(action: {
                    print(isPresented)
                    isEditing = false
                    isPresented = false
                    print(isPresented)
                }, label: {
                    StandardButton(buttonText: "Cancel", buttonColor: Color(.systemRed))
                })
                Button(action: {
                    print("1: \(isPresented)")
                    isEditing = false
                    print("2: \(isPresented)")
                    plates = requestManager.createArray(cycle: requestManager.getCycle(), airport: text)
                    print("9: \(isPresented)")
                    isPresented = false
                    print("10: \(isPresented)")
                }, label: {
                    StandardButton(buttonText: "Search", buttonColor: Color(.systemBlue))
                })
            }
        }
        .padding()
    }
}

struct StandardButton: View {
    
    let buttonText: String
    let buttonColor: Color
    
    var body: some View {
        Text(buttonText)
            .font(.title2)
            .frame(width: 100, height: 40)
            .background(buttonColor)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""), plates: .constant(K.starterPlates), isPresented: .constant(true))
    }
}
