//  
//  CreateNewDestinationViewModel.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 21.01.22.
//


import Combine
import SQLite

class CreateNewDestinationViewModel: ObservableObject{
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var tapButton: Bool = false
    @Published var navigation: Bool = false
    @Published var trips: [Trip] = []
    private var cancallables = Set<AnyCancellable>()
    

    
    private func getDestinations() {
        let mut = CreateNewDestinationMutation(title: self.title, description: self.description)
        Network.shared.apollo.perform(mutation: mut,
                                      publishResultToStore: false,
                                      queue: .main) { result in
            self.trips.append(Trip.init(title: self.title, destination: self.description))
            self.navigation = true
        }

    }
    
    func subscribe() {
        $tapButton.sink { change in
            if change {
                self.getDestinations()
            }
        }.store(in: &cancallables)
        
    }
}
