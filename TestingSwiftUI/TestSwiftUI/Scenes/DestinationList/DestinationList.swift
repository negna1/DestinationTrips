//
//  DestinationList.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 24.01.22.
//

import SwiftUI

struct DestinationList: View {
    @ObservedObject var viewModel: DestinationListViewModel
    var body: some View {
        Text(viewModel.listType.getTitle())
        List {
            ForEach($viewModel.trips) {item in
                HStack (spacing: 20){
                    Image(uiImage: $viewModel.feeds[item.title.wrappedValue].wrappedValue?.getUIImage() ??
                    UIImage())
                        .clipShape(Circle())
                        .scaledToFit()
                        .imageScale(.small)
                        .frame(width: 100, height: 100)
                    Text(item.title.wrappedValue)
                        .fontWeight(.bold)
                    Text(item.destination.wrappedValue)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }
                
            }
        }
        
    }
}
