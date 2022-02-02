//
//  ContentView.swift
//  ContactBook
//
//  Created by Nato Egnatashvili on 15.01.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: contactViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach($viewModel.coreManager.contacts, id: \.self) { n in
                        ContactView(contact: n )
                            .contextMenu{
                                contextButton(removeContact: $viewModel.removedContact,
                                              removeContactReal: n)
                            }
                    }
                }
            }
            .navigationTitle("Contacts")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    alertControl(text: $viewModel.addName,
                                                                mobile: $viewModel.addMobile,
                                                                clickHappend: $viewModel.confirmHappend))
        }
            
        
            .onAppear {
                viewModel.subscribe()
            }
    }
    
}



struct contextButton: View {
    enum ButtonType {
        case remove
        case edit
    }
    var type: ButtonType = .remove
    @Binding var removeContact: ContactModel?
    @Binding var removeContactReal: ContactModel
    var body: some View {
        Button {
            self.removeContact = self.removeContactReal
        } label: {
            HStack {
                Text(type.text)
                    .fontWeight(.heavy)
                type.icon.resizable()
            }
        }
        
    }
}

struct alertControl: View {
    @Binding var text: String
    @Binding var mobile: String
    @Binding var clickHappend: Bool
    var body: some View {
        Button {
            AlertExtension.shared.alert { (name, mob) in
                text = name
                mobile = mob
                clickHappend = !(name.isEmpty || mob.isEmpty)
            }
        } label: {
            Image(systemName: "plus")
        }
    }
}

struct ContactView: View {
    var contact: Binding<ContactModel>
    
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(Color.gray)
                    .frame(width: 40,
                           height: 40,
                           alignment: .center)
                
                Text(contact.wrappedValue.initials)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
            }
            Text(contact.name.wrappedValue ?? "")
                .font(.caption2)
            Text(contact.mobile.wrappedValue ?? "")
                .font(.caption)
            
        }
        .frame(width: 80,
               height:80,
               alignment: .center)
        .border(.gray,
                width: 2)
        .cornerRadius(5)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


extension contextButton.ButtonType {
    var text: String {
        switch self {
        case .edit:
            return "Edit"
            
        case .remove:
            return "Remove"
        }
    }
    
    var icon: Image {
        switch self {
        case .edit:
            return Image(systemName: "trash")
            
        case .remove:
            return Image(systemName: "trash")
        }
    }
}
