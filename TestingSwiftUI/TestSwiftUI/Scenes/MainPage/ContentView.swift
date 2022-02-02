//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 11.01.22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel: MainViewModel
    @State var showDetails: Bool = false
    
    
    static func load(viewModel: MainViewModel) -> ContentView{
        let v = ContentView(viewModel: viewModel)
        v.apparance()
        viewModel.outputs.viewDidLoad()
        return v
    }
    
    var body: some View {
        ZStack {
            getScrollView(viewModel.dataSource)
            
            if showDetails {
                    BlurView(showDetails: $showDetails)
                SettingView().transition(.move(edge: .bottom))
                
            }
        }
        
    }
    
    func getScrollView(_ items: [MainViewModel.DataSourceModel]) -> some View {
        List {
            ForEach(items){e in
                RowItemView(
                    imageName: e.imageName ?? "",
                    title: e.title ?? "")
                    .onTapGesture {
                        self.showDetails = true
                        
                    }
                
            }
        }
        
    }
    
    func apparance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemGray2, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.turn.up.left"), transitionMaskImage: UIImage(systemName: "arrow.turn.up.left"))
        UINavigationBar.appearance().tintColor = .systemGray2
    }
}

struct BlurView: View {
    @Binding var showDetails: Bool
    var body: some View {
        Rectangle()
        
        .background(.black)
        .opacity(0.5)
        .ignoresSafeArea()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        
        .onTapGesture {
            self.showDetails = false
        }
    }
}

struct RowItemView: View {
    var imageName: String
    var title: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .cornerRadius(25)
            Text(title)
                .fontWeight(.heavy)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mainModel = MainViewModel()
        return ContentView.load(viewModel: mainModel)
    }
}
