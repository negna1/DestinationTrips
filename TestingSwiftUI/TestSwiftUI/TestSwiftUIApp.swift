//
//  TestSwiftUIApp.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 11.01.22.
//

import SwiftUI

@main
struct TestSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            //ValidRegistration(viewModel: ValidRegistrationSecondViewModel())
            Destination(viewModel: DestinationViewModel())
        }
    }
}

