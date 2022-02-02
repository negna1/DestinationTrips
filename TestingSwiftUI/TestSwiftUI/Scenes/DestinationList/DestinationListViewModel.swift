//
//  DestinationListViewModel.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 24.01.22.
//

import Combine
import Foundation

class DestinationListViewModel: ObservableObject {
    enum ListType {
        case X
        case Heart
    }
    
    @Published var trips: [Trip]
    var listType: ListType
    @Published var navigation: Bool = false
    //outputs
    @Published var viewDidLoadHappend: Bool = false
    @Published var feeds: [String: FlickrFeed]
    private var firstTime: Bool = false
    
    private var cancallables = Set<AnyCancellable>()
    
    init(type: ListType,
         trips: [Trip],
         feeds:  [String: FlickrFeed]) {
        self.trips = trips
        self.listType = type
        self.feeds = feeds
        subscribe()
    }
    
    
    func subscribe() {
        $feeds.sink { res in
            print(res)
        }.store(in: &cancallables)
    }
    
//    func outputSubscribes() {
//
//        $viewDidLoadHappend.sink { happpend in
//            if happpend {self.viewDidLoad()}
//        }.store(in: &cancallables)
//    }
}


extension DestinationListViewModel.ListType {
    func getTitle() -> String{
        switch self {
        case .Heart:
            return "Your Favourite Destinations"
        case .X:
            return "Your Disliked Destinations"
        }
    }
}

