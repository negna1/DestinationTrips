//
//  HeartAnimationImplicit.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 12.01.22.
//

import SwiftUI

struct HeartAnimationImplicit: View {
    @State var animation: Bool = true
    @State var circleColorChange: Bool = false
    @State var heartColorChange: Bool = false
    @State var heartSizeDouble: Bool = false
    var body: some View {
        ZStack {
            Circle()
                .fill( circleColorChange ? Color.gray : Color.red)
                .frame(width: 200, height: 200)
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChange ? Color.red : Color.gray)
                .font(.system(size: 25))
                .frame(width: 50, height: 50)
                .scaleEffect(heartSizeDouble ? 2 : 1)
                
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3), value: circleColorChange)
        .onTapGesture {
            circleColorChange.toggle()
            heartColorChange.toggle()
            heartSizeDouble.toggle()
        }
    }
}

struct HeartAnimationImplicit_Previews: PreviewProvider {
    static var previews: some View {
        HeartAnimationImplicit()
    }
}
