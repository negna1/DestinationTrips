// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetDestinationQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetDestination {
      getDestination(id: 1) {
        __typename
        destination {
          __typename
          id
          title
          description
          created_at
        }
        success
        errors
      }
    }
    """

  public let operationName: String = "GetDestination"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getDestination", arguments: ["id": 1], type: .nonNull(.object(GetDestination.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getDestination: GetDestination) {
      self.init(unsafeResultMap: ["__typename": "Query", "getDestination": getDestination.resultMap])
    }

    public var getDestination: GetDestination {
      get {
        return GetDestination(unsafeResultMap: resultMap["getDestination"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "getDestination")
      }
    }

    public struct GetDestination: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["DestinationResult"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("destination", type: .object(Destination.selections)),
          GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("errors", type: .list(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(destination: Destination? = nil, success: Bool, errors: [String?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "DestinationResult", "destination": destination.flatMap { (value: Destination) -> ResultMap in value.resultMap }, "success": success, "errors": errors])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var destination: Destination? {
        get {
          return (resultMap["destination"] as? ResultMap).flatMap { Destination(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "destination")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var errors: [String?]? {
        get {
          return resultMap["errors"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "errors")
        }
      }

      public struct Destination: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Destination"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .nonNull(.scalar(String.self))),
            GraphQLField("created_at", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String, description: String, createdAt: String) {
          self.init(unsafeResultMap: ["__typename": "Destination", "id": id, "title": title, "description": description, "created_at": createdAt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var createdAt: String {
          get {
            return resultMap["created_at"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "created_at")
          }
        }
      }
    }
  }
}

public final class GetDestinationsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetDestinations {
      listDestinations {
        __typename
        destination {
          __typename
          title
          description
        }
        success
        errors
      }
    }
    """

  public let operationName: String = "GetDestinations"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("listDestinations", type: .nonNull(.object(ListDestination.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(listDestinations: ListDestination) {
      self.init(unsafeResultMap: ["__typename": "Query", "listDestinations": listDestinations.resultMap])
    }

    public var listDestinations: ListDestination {
      get {
        return ListDestination(unsafeResultMap: resultMap["listDestinations"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "listDestinations")
      }
    }

    public struct ListDestination: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["DestinationsResult"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("destination", type: .list(.object(Destination.selections))),
          GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("errors", type: .list(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(destination: [Destination?]? = nil, success: Bool, errors: [String?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "DestinationsResult", "destination": destination.flatMap { (value: [Destination?]) -> [ResultMap?] in value.map { (value: Destination?) -> ResultMap? in value.flatMap { (value: Destination) -> ResultMap in value.resultMap } } }, "success": success, "errors": errors])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var destination: [Destination?]? {
        get {
          return (resultMap["destination"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Destination?] in value.map { (value: ResultMap?) -> Destination? in value.flatMap { (value: ResultMap) -> Destination in Destination(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Destination?]) -> [ResultMap?] in value.map { (value: Destination?) -> ResultMap? in value.flatMap { (value: Destination) -> ResultMap in value.resultMap } } }, forKey: "destination")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var errors: [String?]? {
        get {
          return resultMap["errors"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "errors")
        }
      }

      public struct Destination: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Destination"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String, description: String) {
          self.init(unsafeResultMap: ["__typename": "Destination", "title": title, "description": description])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }
      }
    }
  }
}

public final class CreateNewDestinationMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateNewDestination($title: String!, $description: String!) {
      createDestination(title: $title, description: $description) {
        __typename
        destination {
          __typename
          id
          title
          description
          created_at
        }
        success
        errors
      }
    }
    """

  public let operationName: String = "CreateNewDestination"

  public var title: String
  public var description: String

  public init(title: String, description: String) {
    self.title = title
    self.description = description
  }

  public var variables: GraphQLMap? {
    return ["title": title, "description": description]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createDestination", arguments: ["title": GraphQLVariable("title"), "description": GraphQLVariable("description")], type: .nonNull(.object(CreateDestination.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createDestination: CreateDestination) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createDestination": createDestination.resultMap])
    }

    public var createDestination: CreateDestination {
      get {
        return CreateDestination(unsafeResultMap: resultMap["createDestination"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "createDestination")
      }
    }

    public struct CreateDestination: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["DestinationResult"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("destination", type: .object(Destination.selections)),
          GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("errors", type: .list(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(destination: Destination? = nil, success: Bool, errors: [String?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "DestinationResult", "destination": destination.flatMap { (value: Destination) -> ResultMap in value.resultMap }, "success": success, "errors": errors])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var destination: Destination? {
        get {
          return (resultMap["destination"] as? ResultMap).flatMap { Destination(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "destination")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var errors: [String?]? {
        get {
          return resultMap["errors"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "errors")
        }
      }

      public struct Destination: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Destination"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .nonNull(.scalar(String.self))),
            GraphQLField("created_at", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String, description: String, createdAt: String) {
          self.init(unsafeResultMap: ["__typename": "Destination", "id": id, "title": title, "description": description, "created_at": createdAt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var createdAt: String {
          get {
            return resultMap["created_at"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "created_at")
          }
        }
      }
    }
  }
}
