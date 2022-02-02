//
//  ValidRegistrationSecondViewModel.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 14.01.22.
//

import Combine
import Foundation


class ValidRegistrationSecondViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    
    @Published var pushView: Bool = false
    @Published var tapped: Bool = false
    @Published var usernameMinimumCharacterValid: Bool = true
    @Published var passwordMinimumCharacterValid: Bool = true
    @Published var passwordUpperValid: Bool = true
    @Published var passwordConfirmSameValid: Bool = true
    
    private var cancellable = Set<AnyCancellable>()
    
    func subcribes() {
        $tapped
            .receive(on: RunLoop.main)
            .map { repeatPassword in
                let tr = self.usernameMinimumCharacterValid &&
                self.passwordMinimumCharacterValid &&
                self.passwordUpperValid &&
                self.passwordConfirmSameValid
                return repeatPassword && tr
            }
            .assign(to: \.pushView, on: self)
            .store(in: &cancellable)
        
        $repeatPassword
            .receive(on: RunLoop.main)
            .map { repeatPassword in
                return repeatPassword == self.password && self.password.count > 0
            }
            .assign(to: \.passwordConfirmSameValid, on: self)
            .store(in: &cancellable)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.passwordMinimumCharacterValid, on: self)
            .store(in: &cancellable)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.contains(where: {$0.isUppercase})
            }
            .assign(to: \.passwordUpperValid, on: self)
            .store(in: &cancellable)
        
        $username
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 4
            }
            .assign(to: \.usernameMinimumCharacterValid, on: self)
            .store(in: &cancellable)
    }
}
