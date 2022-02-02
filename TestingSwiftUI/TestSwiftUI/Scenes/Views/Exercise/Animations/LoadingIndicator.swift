//
//  LoadingIndicator.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 12.01.22.
//

import SwiftUI

struct LoadingIndicator: View {
    @State var isLoading: Bool = false
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 5)
                .frame(width: 50, height: 50)
            Circle()
                .trim(from: 0, to: 0.3)
                .stroke(Color.red, lineWidth: 5)
                .frame(width: 50, height: 50)
                .rotationEffect( Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.easeIn(duration: 4).repeatForever(autoreverses: false),
                           value: isLoading)
                .onAppear {
                    isLoading = true
                }
            Text("Loading")
                .font(.caption2)
                .fontWeight(.heavy)
        }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
