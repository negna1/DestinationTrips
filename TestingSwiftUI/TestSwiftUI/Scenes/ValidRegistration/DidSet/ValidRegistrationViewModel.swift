//
//  ValidRegistrationViewModel.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 14.01.22.
//

import Foundation


class ValidRegistrationViewModel: ObservableObject {
    @Published var username: String = "" {
        didSet {
            self.usernameMinimumCharacterValid = username.count <= 4
        }
    }
    @Published var password: String = "" {
        didSet {
            self.passwordMinimumCharacterValid = password.count <= 8
            self.passwordUpperValid = self.password.contains(where: {$0.isUppercase})
        }
    }
    
    @Published var repeatPassword: String = "" {
        didSet {
            self.passwordConfirmSameValid = password == repeatPassword
        }
    }
    
    @Published var tapped: Bool = false {
        didSet {
            let valid = usernameMinimumCharacterValid
            && passwordMinimumCharacterValid
            && passwordUpperValid
            && passwordConfirmSameValid
            print(valid)
        }
    }
    
    @Published var usernameMinimumCharacterValid: Bool = true
    @Published var passwordMinimumCharacterValid: Bool = true
    @Published var passwordUpperValid: Bool = true
    @Published var passwordConfirmSameValid: Bool = true
}
