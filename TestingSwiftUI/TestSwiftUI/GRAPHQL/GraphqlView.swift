//
//  GraphqlView.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 13.01.22.
//

import SwiftUI

struct GraphqlView: View {
    @State var data: [String] = []
    var body: some View {
        List {
            ForEach(data) { d in
                Text(d)
            }
        }.listStyle(PlainListStyle())
    }
}

extension String: Identifiable {
    public var id: String {return self}
}

struct GraphqlView_Previews: PreviewProvider {
    static var previews: some View {
        GraphqlView()
    }
}
