
import Foundation
import GraphZahl

enum UserRole: String, GraphQLEnum, Codable, CaseIterable {
    case admin
    case moderator
    case user
}
