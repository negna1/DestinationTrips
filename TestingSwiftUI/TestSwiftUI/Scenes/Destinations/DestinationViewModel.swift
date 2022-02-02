//
//  DestinationViewModel.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 21.01.22.
//

import Combine
import Foundation
import SwiftUI

struct Trip: Identifiable {
    var id: UUID = UUID()
    var title: String
    var destination: String
    var image: String = "tokyo-japan"
    static let emptyTrip: Self = Trip.init(title: "", destination: "")
}


class DestinationViewModel: ObservableObject {
    @Published var tipsIndex: Int = 0
    @Published var trips: [Trip] = []
    @Published var currentTrip: Trip = Trip.emptyTrip
    @Published var nextTrip: Trip = Trip.emptyTrip
    
    @Published var currentField: FlickrFeed = FlickrFeed()
    @Published var nextField: FlickrFeed = FlickrFeed()
    
    @Published var hasNext: Bool = false
    @Published var tapButton: Bool = false
    @Published var navigation: Bool = false
    @Published var isLast: Bool = false
    //outputs
    @Published var viewDidLoadHappend: Bool = false
    @Published var XTapHappend: Bool = false
    @Published var heartTapHappend: Bool = false
    
    //Routing
    @Published var XRouting: Bool = false
    @Published var heartRouting: Bool = false
    @Published var XHeartView: DestinationList?
    @Published var createNewView: CreateNewDestination?
    @Published var feeds: [String: FlickrFeed] = [:]
    
    private var firstTime: Bool = false
    
   private var xes: [Trip] = []
    private var hes: [Trip] = []
    private var cancallables = Set<AnyCancellable>()
    
    private func viewDidLoad() {
        if !firstTime {
            getDestinations()
            firstTime = true
            let model = CreateNewDestinationViewModel()
            model.$trips = self.$trips
            createNewView =  CreateNewDestination(viewModel: CreateNewDestinationViewModel())
        }  
    }
    
    private func heartHappend() {
        if trips.count > tipsIndex {
            hes.append(trips[tipsIndex])
            tipsIndex += 1
        }
    }
    
    private func xHappend() {
        if trips.count > tipsIndex  {
            xes.append(trips[tipsIndex])
            tipsIndex += 1
        }
    }
    
    func setup2(title: String) {

        DispatchQueue.main.async {
            if let flickrURL = URL(string:
                "https://api.flickr.com/services/feeds/photos_public.gne?%20tags=" + title + "&tagmode=any&format=json&nojsoncallback=1%22") {

                
                let session = URLSession.shared
                session.dataTask(with: flickrURL) { data, response, error in
                    guard let data = data else {
                        return
                    }
                    let wrapper = try? JSONDecoder().decode(FlicrResponse.self
                                                            , from: data)
                    
                    DispatchQueue.main.async {
                        self.feeds[title] = wrapper!.items.first
                    }
                }.resume()
            }
        }
        
    }
    
    private func getDestinations() {
        Network.shared.apollo.fetch(query: GetDestinationsQuery()) {result in
                switch result {
                    
                case .success(let res):
                    guard let dat = res.data?.listDestinations.destination else { return }
                    self.trips = dat.map({
                        Trip.init(title: $0?.title ?? "",
                                  destination: $0?.description ?? "")})
                    self.tipsIndex = 0
                    for i in self.trips {
                        self.setup2(title: i.title)
                    }
                case .failure(_):
                    print("Error")
                }
            }

    }
    
    func initialPublishers() {
        
    }
    func sunscribe() {
        guard !firstTime else { return }
        $trips.sink { trips in
            guard self.tipsIndex < trips.count else {
                return
            }
            trips.forEach({ trp in
                if self.feeds[trp.title] == nil {
                    self.setup2(title: trp.title)
                }
            })
            self.currentTrip = trips[self.tipsIndex]
            self.nextTrip = trips[self.tipsIndex]
        }.store(in: &cancallables)
        
        $tipsIndex.receive(on: RunLoop.main)
        .map { index in
            return index < self.trips.count - 1
        }
        .assign(to: \.hasNext, on: self)
        .store(in: &cancallables)
        
        $tipsIndex.receive(on: RunLoop.main)
        .map { index in
            return index == self.trips.count - 1
        }
        .assign(to: \.isLast, on: self)
        .store(in: &cancallables)
        
        $hasNext.sink { val in
            self.currentTrip = self.nextTrip
            self.currentField = self.nextField
            if val {
                self.nextTrip = self.trips[self.tipsIndex+1]
                self.nextField = self.feeds[self.nextTrip.title] ?? FlickrFeed()
            }
        }.store(in: &cancallables)
        
        $feeds.sink { dict in
            self.currentField = dict[self.currentTrip.title] ?? FlickrFeed()
            self.nextField = dict[self.nextTrip.title] ?? FlickrFeed()
        }.store(in: &cancallables)
    }
    
    func outputSubscribes() {
        guard !firstTime else { return }
        $tapButton.sink { change in
            if change {
                self.navigation = true
            }
            
        }.store(in: &cancallables)
        
        $viewDidLoadHappend.sink { happpend in
            if happpend {self.viewDidLoad()}
        }.store(in: &cancallables)
        $XTapHappend.sink { happend in
            if happend {self.xHappend()}
        }.store(in: &cancallables)
        $heartTapHappend.sink { happend in
            if happend {self.heartHappend()}
        }.store(in: &cancallables)
    }
}



extension DestinationViewModel {
    func forRoutingSubscribe() {
        guard !firstTime else { return }
        $XRouting.sink { route in
            if route {
                let model = DestinationListViewModel.init(type: .X,
                                                          trips: self.xes,
                                                          feeds: self.feeds)
                self.XHeartView = DestinationList(viewModel: model)
            }
        }.store(in: &cancallables)
        
        $heartRouting.sink { route in
            if route {
                let model = DestinationListViewModel.init(type: .Heart,
                                                          trips: self.hes,
                                                          feeds: self.feeds)
                self.XHeartView = DestinationList(viewModel: model)
            }
        }.store(in: &cancallables)
    }
}
