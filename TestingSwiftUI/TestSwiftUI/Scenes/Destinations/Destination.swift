//
//  Destination.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 21.01.22.
//

import SwiftUI

struct Destination: View {
    private let dragThreshold: CGFloat = 80.0
    @ObservedObject var viewModel: DestinationViewModel
    @GestureState private var dragState = DragState.inactive
    @State var popToHere : Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack {
//                NavigationLink("",
//                               isActive: $viewModel.tapButton,
//                               destination: {
//                    let model = CreateNewDestinationViewModel()
//                    model.$trips = viewModel.$trips
//                    CreateNewDestination(viewModel: CreateNewDestinationViewModel())
//
//                })
                TopBarMenu(tapButton: $viewModel.tapButton)
                Spacer()
                    ZStack {
                        if $viewModel.hasNext.wrappedValue || $viewModel.isLast.wrappedValue {
                            if $viewModel.hasNext.wrappedValue {
                                CardView(trip: $viewModel.nextTrip,
                                         field: $viewModel.nextField)
                            }else if $viewModel.isLast.wrappedValue {
                                Spacer()
                            }
                            CardViewAnimation(currentTrip: $viewModel.currentTrip,
                                              heartHappend: $viewModel.heartTapHappend,
                                              XHappend: $viewModel.XTapHappend,
                                              field: $viewModel.currentField,
                                              dragState: dragState)
                        }else {
                            Spacer()
                        }
                    }
                Spacer()
                BottomBarMenu(xTap: $viewModel.XRouting,
                              heartTap: $viewModel.heartRouting,
                              XHeartView: $viewModel.XHeartView)
            }.navigationTitle("Destinations")
                .navigationBarTitleDisplayMode(.inline)
            
                
                .onAppear {
                    viewModel.sunscribe()
                    viewModel.outputSubscribes()
                    viewModel.forRoutingSubscribe()
                    viewModel.viewDidLoadHappend = true
                }
        }
    }
    
    struct CardViewAnimation: View {
        @Binding var currentTrip: Trip
        @Binding var heartHappend: Bool
        @Binding var XHappend: Bool
        @Binding var field: FlickrFeed
        @GestureState var dragState: Destination.DragState
        private let dragThreshold: CGFloat = 80.0
        var body: some View {
            CardView(trip: $currentTrip, field: $field)
                .offset(x: self.dragState.translation.width, y: self.dragState.translation.height)
                .scaleEffect(self.dragState.isDragging ? 0.95 : 1.0)
                .rotationEffect(Angle(degrees: Double( self.dragState.translation.width / 10)))
                .animation(.interpolatingSpring(stiffness: 180, damping: 100))
                .gesture(LongPressGesture(minimumDuration: 0.01)
                            .sequenced(before: DragGesture())
                            .updating($dragState, body: { value, state, transition in
                    switch value {
                    case .first(_):
                        state = .pressing
                    case .second(_,let val):
                        state = .dragging(translation: val?.translation ?? CGSize(width: 0,height: 0))
                        
                        
                    }
                }).onEnded({ value in
                    switch value {
                    case .second(_, let val):
                        guard let drag = val else { return }
                        if drag.translation.width < -self.dragThreshold  {
                            XHappend = true
                        }
                        
                        if drag.translation.width > self.dragThreshold  {
                            heartHappend = true
                        }
                    default: break
                    }
                })
                ).overlay(
                    ZStack {
                        Image(systemName: "x.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 100))
                            .opacity(self.dragState.translation.width < -dragThreshold
                                     && self.dragState.translation.width != 0 ? 1 : 0)
                        
                        Image(systemName: "heart")
                            .foregroundColor(.white)
                            .font(.system(size: 100))
                            .opacity(self.dragState.translation.width > dragThreshold
                                     && self.dragState.translation.width != 0 ? 1 : 0)
                    }
                )
        }
    }
    
    
    struct CardView: View {
        @Binding var trip: Trip
        @Binding var field: FlickrFeed
        var body: some View {
            Image(uiImage: field.getUIImageLarge() ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300, alignment: .center)
                .cornerRadius(10)
                .padding([.leading, .bottom, .trailing], 10.0)
                .overlay(
                    VStack {
                        Text(trip.title)
                            .fontWeight(.bold)
                            .font(.system(.title,
                                          design: .rounded))
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color.white)
                        
                            .cornerRadius(5)
                        Text(trip.destination)
                            .font(.system(.body,
                                          design: .rounded))
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color.white)
                        
                            .cornerRadius(5)
                    }.padding([.bottom], 40)
                    
                    , alignment: .bottom)
            
        }
    }
    
    struct TopBarMenu: View {
        @Binding var tapButton: Bool
        var body: some View {
            HStack {
                Button {
                    tapButton = true
                } label: {
                    Image(systemName: "line.horizontal.3")
                }
                Spacer()
                Image(systemName: "mappin.and.ellipse")
                Spacer()
                Image(systemName: "heart.circle.fill")
                
            }.padding(.horizontal, 20)
            
        }
    }
    
    struct BottomBarMenu: View {
        @Binding var xTap: Bool
        @Binding var heartTap: Bool
        @Binding var XHeartView: DestinationList?
        
        var body: some View {
            HStack {
                if XHeartView != nil {
                    NavigationLink("",
                                   isActive: $xTap,
                                   destination: {XHeartView!})
                    NavigationLink("",
                                   isActive: $heartTap,
                                   destination: {XHeartView!})
                }
                
                Button {
                    xTap = true
                   
                } label: {
                    Image(systemName: "xmark")
                }
                
                Spacer()
                Button {
                    //Action
                } label: {
                    Text("Book Here")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(5)
                }
                
                Spacer()
                Button {
                    heartTap = true
                } label: {
                    Image(systemName: "heart")
                }
                
                
            }.padding(.horizontal, 20)
                .padding(.vertical, 10)
        }
    }
}



extension Destination {
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
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            } }
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            } }
    }
}
