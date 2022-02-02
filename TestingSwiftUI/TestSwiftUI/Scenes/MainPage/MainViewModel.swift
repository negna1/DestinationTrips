//
//  MainViewModel.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 11.01.22.
//

import SwiftUI
import Combine


protocol MainViewModelType {
    var outputs: MainViewModelOutputs {get}
}

protocol MainViewModelOutputs {
    func viewDidLoad()
}

class MainViewModel:  MainViewModelOutputs, ObservableObject {
    struct DataSourceModel {
        let imageName: String?
        let title: String?
        let description: String?
    }
    
    @Published var showLoader: Bool
    @Published var dataSource: [DataSourceModel]
    init() {
        self.showLoader = false
        self.dataSource = []
    }
    
    func viewDidLoad() {
        let models = DataSourceModel.mock2
        self.showLoader = true
        self.dataSource = models
    }
    
}

extension MainViewModel: MainViewModelType  {
    
    var outputs: MainViewModelOutputs {return self}
}

extension MainViewModel.DataSourceModel: Identifiable {
    var id: String { self.description ?? "" }
    
    static var mock: [MainViewModel.DataSourceModel] {
        return []
    }
    
    static var mock2: [MainViewModel.DataSourceModel] {
        let f = MainViewModel.DataSourceModel(
            imageName: "ic_paris",
            title: "Paris",
            description: "Paris, France's capital, is a major European city and a global center for art, fashion, gastronomy and culture. Its 19th-century cityscape is crisscrossed by wide boulevards and the River Seine.")
        let f2 = MainViewModel.DataSourceModel(
            imageName: "ic_london",
            title: "London",
            description: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. ")
        return [f,f2]
    }
}
