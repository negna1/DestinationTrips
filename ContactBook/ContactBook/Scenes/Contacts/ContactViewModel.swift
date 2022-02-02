//
//  ContactViewModel.swift
//  ContactBook
//
//  Created by Nato Egnatashvili on 15.01.22.
//

import Combine
import Foundation

class contactViewModel: ObservableObject {
    @Published var addName: String = ""
    @Published var addMobile: String = ""
    @Published var confirmHappend: Bool = false
    @Published var removedContact: ContactModel?
    
    var cancellable = Set<AnyCancellable>()
    @Published var coreManager: PersistenceController
    
    init(coreManager: PersistenceController) {
        self.coreManager = coreManager
    }
    
    
    func subscribe() {
        $confirmHappend.sink(receiveValue: { bl in
            self.saveContact()
        })
            .store(in: &cancellable)
        
        $removedContact.sink { contactModel in
            guard let removedContact = contactModel else {
                return
            }
            self.coreManager.remove(contact: removedContact)
        }
        .store(in: &cancellable)
    }
    
    func saveContact() {
        if !(self.addName.isEmpty && self.addMobile.isEmpty) {
            coreManager.save(title: addName,
                             mobile: addMobile)
        }
    }
    
}

extension ContactModel {
    var initials: String {
        guard let arr = self.name?.components(separatedBy: " ") else {return "Unknown"}
        if arr.isEmpty {return ""}
        if arr.count == 1 {return String(Array(arr[0]).first!)}
        if arr.count == 2 {return  String(Array(arr[0]).first!) + String(Array(arr[1]).first!)}
        return "Unknown"
    }
}
