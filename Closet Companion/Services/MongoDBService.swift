import MongoSwift
import Foundation

struct MongoDBService {
    static let shared = MongoDBService()
    private var client: MongoClient?

    private init() {
        do {
            let connectionString = ProcessInfo.processInfo.environment["MONGODB_URI"] ?? "mongodb+srv://garrett6648:<db_password>@closetdbcluster.jnyky.mongodb.net/?retryWrites=true&w=majority&appName=ClosetDBCluster"
            self.client = try MongoClient(connectionString)
            print("Connected to MongoDB")
        } catch {
            print("Error connecting to MongoDB: \(error)")
        }
    }

    func getDatabase(named name: String) -> MongoDatabase? {
        return client?.db(name)
    }

    func getCollection<T: Codable>(dbName: String, collectionName: String) -> MongoCollection<T>? {
        return getDatabase(named: dbName)?.collection(collectionName)
    }
}
