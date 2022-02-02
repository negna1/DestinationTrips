//
//  Persistence.swift
//  ContactBook
//
//  Created by Nato Egnatashvili on 15.01.22.
//

import Foundation
import SwiftUI
import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    private let container: NSPersistentContainer
    @Published var contacts: [ContactModel] = []

    func save(title: String, mobile: String) {
        let contact = ContactModel(context: container.viewContext)
        contact.name = title
        contact.mobile = mobile

            do {
                try container.viewContext.save()
                self.contacts = getAll()
            } catch {
                // Show some error here
            }
    }
    
    func remove(contact: ContactModel) {
        container.viewContext.delete(contact)
            do {
                try container.viewContext.save()
                self.contacts = getAll()
            } catch {
                // Show some error here
            }
    }
    
    func getAll() -> [ContactModel]{
        let fetchReq: NSFetchRequest<ContactModel> = ContactModel.fetchRequest()
        
        do {
            return try container.viewContext.fetch(fetchReq)
        } catch {
            return []
        }
    }
    
    init() {
        container = NSPersistentContainer(name: "Contact")

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        contacts = getAll()
    }
}
