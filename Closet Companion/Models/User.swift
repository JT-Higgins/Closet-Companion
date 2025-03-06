import MongoSwift

struct User: Codable {
    let _id: BSONObjectID?
    let name: String
    let email: String
}