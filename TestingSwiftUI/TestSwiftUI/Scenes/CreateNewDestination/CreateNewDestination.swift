//  
//  CreateNewDestinationController.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 21.01.22.
//


import SwiftUI
struct CreateNewDestination: View {
    @ObservedObject var viewModel: CreateNewDestinationViewModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        VStack {
            Text("Create New Destination")
                .font(.title)
                .foregroundColor(.indigo)
            TextField("Title",
                      text: $viewModel.title)
                .textFieldStyle(.roundedBorder)
            TextField("Description",
                      text: $viewModel.description)
                .textFieldStyle(.roundedBorder)
            PrimaryButton(tapButton: $viewModel.tapButton)
        }
        .padding()
        
        .onAppear {
            viewModel.subscribe()
            
        }.onReceive(viewModel.$navigation) { publisher in
            if publisher {
                mode.wrappedValue.dismiss()
            }
        }
    }
    
    struct PrimaryButton: View {
        @Binding var tapButton: Bool
        var body: some View {
            Button {
                tapButton = true
            } label: {
                Text("Confirm")
            }
        }
    }
        
}




