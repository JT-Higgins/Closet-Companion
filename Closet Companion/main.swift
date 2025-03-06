import Foundation

// Get the user collection
let userCollection = MongoDBService.shared.getCollection(dbName: "ClosetCompanionDB", collectionName: "users") as MongoCollection<User>?

// Insert a new user
let newUser = User(_id: nil, name: "John", email: "john@example.com")

do {
    try userCollection?.insertOne(newUser)
    print("User inserted successfully")
} catch {
    print("Error inserting user: \(error)")
}

// Fetch users
do {
    let users = try userCollection?.find().toArray()
    print("Users in DB: \(users ?? [])")
} catch {
    print("Error fetching users: \(error)")
}
