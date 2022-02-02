//
//  PageDescription.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 11.01.22.
//

import SwiftUI

struct PageDescription: View {
    let imageName: String?
    let title: String?
    let description: String?
    
    
    
    var body: some View {
        VStack {
            getImage(imageName: imageName)
            configureTitle(title: title)
            configureDescription(title: description)
        }.padding(EdgeInsets.init(top: 5,
                                  leading: 16,
                                  bottom: 5,
                                  trailing: 16))
        .background(Color.canvas)
            .padding()
            .cornerRadius(10)
            
    }
    
    func getImage(imageName: String?) -> some View {
        imageName.map({
            Image($0)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(width: 100,
                       height: 100,
                       alignment: .center)
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
        })
        
    }
    
}

struct PageDescription_Previews: PreviewProvider {
    static var previews: some View {
        PageDescription(imageName: "ic_wave",
                        title: "Wave",
                        description: "wave and see what hapdnnnn")
    }
}
