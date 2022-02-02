//
//  Exercise.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 11.01.22.
//

import SwiftUI

struct Exercise: View {
    @State private var first: Int = 0
    @State private var second: Int = 0
    @State private var third: Int = 0

    var body: some View {
        VStack {
            Spacer()
            Text((first+second+third).description)
                .font(.largeTitle)
                .fontWeight(.heavy)
            Spacer()
            HStack {
                Circle_button(cnt: $first, color: .canvas)
                Circle_button(cnt: $second, color: .red)
                Circle_button(cnt: $third, color: .green)
            }
            Spacer()
        }
    }
}

struct Circle_button: View {
    @Binding var cnt: Int
    var color: Color
    var body: some View {
        Button {
            cnt += 1
        } label: {
            Text(cnt.description)
                .foregroundColor(.black)
        }.frame(width: 100, height: 100)
            .background(Circle()
                            .foregroundColor(color))
    }
}


struct Exercise_Previews: PreviewProvider {
    static var previews: some View {
        Exercise()
    }
}
