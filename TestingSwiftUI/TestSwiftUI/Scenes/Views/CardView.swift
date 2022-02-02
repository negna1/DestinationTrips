//
//  CardView.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 11.01.22.
//

import SwiftUI

struct CardViews: View {
    let imageName: String?
    let title: String?
    let description: String?
    
    
    
    var body: some View {
        VStack {
            getImage(imageName: imageName)
            configureTitle(title: title)
            configureDescription(title: description)
        }.background(RoundedRectangle(cornerRadius: 8, style:   .circular).fill(Color.canvas))            .cornerRadius(10)
    }
    
    func getImage(imageName: String?) -> some View {
        imageName.map({
            Image($0)
                .resizable()
                .scaledToFit()
        })
    }
    
    func configureTitle(title: String?)  -> some View  {
        title.map({
            Text($0)
                .font(.headline)
                .foregroundColor(.black)
        })
    }
    
    func configureDescription(title: String?)  -> some View  {
        title.map({
            Text($0)
                .font(.subheadline)
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
        })
        
    }
    
}

extension Color {
    static var canvas: Color {
        Color.init(UIColor.init(named: "canvas")!)
    }
}
