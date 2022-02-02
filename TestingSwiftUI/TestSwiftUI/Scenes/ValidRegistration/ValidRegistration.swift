//
//  ValidRegistration.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 14.01.22.
//

import SwiftUI
import Combine

struct ValidRegistration: View {
    @ObservedObject var viewModel: ValidRegistrationSecondViewModel
    var body: some View {
        NavigationView {
            VStack {
                
                FormField(text: $viewModel.username,
                          title: "username")
                ValidationField(isValid: $viewModel.usernameMinimumCharacterValid,
                                icon: "xmark.square",
                                title: "A minimum of 4 character")
                
                FormField(text: $viewModel.password,
                          title: "password",
                          secured: true)
                
                ValidationField(isValid: $viewModel.passwordMinimumCharacterValid,
                                icon: "lock.open",
                                title: "A minimum of 8 character")
                ValidationField(isValid: $viewModel.passwordUpperValid,
                                icon: "lock.open",
                                title: "password must contain upper case character")
                FormField(text: $viewModel.repeatPassword,
                          title: "repeat password",
                          secured: true)
                ValidationField(isValid: $viewModel.passwordConfirmSameValid,
                                icon: "xmark.square",
                                title: "must be same as password")
                
                
                NavigationLink( destination: GraphqlView(),
                               isActive: $viewModel.pushView) {
                   
                    ConfirmationButton(tapped: $viewModel.tapped,
                                       title: "Sign In")
                }
                Spacer()
            }.navigationTitle("Sign in")
        }
        .padding([.top, .leading, .trailing], 10.0)
        .onAppear {
            self.viewModel.subcribes()
        }
        
    }
}

struct FormField: View {
    @Binding var text: String
    var title: String
    var secured: Bool = false
    
    var body: some View {
        secured ?
        AnyView(SecureField(title, text: $text)
                    .textFieldStyle(.roundedBorder)) :
        AnyView(TextField(title, text: $text)
                    .textFieldStyle(.roundedBorder))
        
    }
}

struct ValidationField: View {
    @Binding var isValid: Bool
    var icon: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .renderingMode(.template)
                .resizable()
                .frame(width: 15,
                       height: 15)
                .foregroundColor(isValid ? .red : .black)
            
            Text(title)
                .strikethrough(!isValid)
            Spacer()
        }
        .padding([.top, .leading, .trailing], 10.0)
    }
}

struct ConfirmationButton: View {
    @Binding var tapped: Bool
    var title: String
    
    var body: some View {
        
        Button(action: {
            self.tapped = true
            
        }) {
            Text(title)
                .frame(width: 200 , height: 50, alignment: .center)
        }
        .background(Color.canvas)
        .foregroundColor(Color.black)
        .cornerRadius(5)
        .padding([.top, .leading, .trailing], 10.0)
    }
    
}


struct ValidRegistration_Previews: PreviewProvider {
    static var previews: some View {
        ValidRegistration(viewModel: ValidRegistrationSecondViewModel())
    }
}
