//
//  SettingView.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 13.01.22.
//

import SwiftUI

struct SettingView: View {
    @GestureState var dragState = DragState.inactive
    @State private var positionOffset: CGFloat = 0.0
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
    } }
        var isDragging: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
    } }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HandlerBar()
                ScrollView() {
                    GraphqlView()
                        .frame(height:  UIScreen.main.bounds.height/2)
                }.disabled(true)
            }
            .offset(y: UIScreen.main.bounds.height/2 + self.dragState.translation.height + self.positionOffset)
            .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            .edgesIgnoringSafeArea(.all)
            .gesture(DragGesture()
            .updating(self.$dragState, body: { (value, state, transaction) in
                    state = .dragging(translation: value.translation)
                print("lola")
            }))
        }
       
            
    }
}

struct HandlerBar: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .cornerRadius(10)
            .frame(width: 100, height: 5,
                   alignment: .center)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
