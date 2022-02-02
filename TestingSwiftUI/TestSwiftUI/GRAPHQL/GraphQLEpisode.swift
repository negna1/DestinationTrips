//
//  GraphQLEpisode.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 13.01.22.
//

import Apollo


class Network {
    static let shared = Network()
    lazy var apollo = ApolloClient.init(url: URL(string: "http://127.0.0.1:5000/graphql")!)
 
}
