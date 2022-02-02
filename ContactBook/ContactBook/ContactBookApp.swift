//
//  ContactBookApp.swift
//  ContactBook
//
//  Created by Nato Egnatashvili on 15.01.22.
//

import SwiftUI

@main
struct ContactBookApp: App {
    var body: some Scene {
        WindowGroup {
            let model = contactViewModel(coreManager: PersistenceController.shared)
            ContentView(viewModel: model)
        }
    }
}
