import MongoSwift
import NIO

let elg = MultiThreadedEventLoopGroup(numberOfThreads: 4)

let uri = "mongodb+srv://admin:<Admin1234!>@cis320-app-cluster.jggymwr.mongodb.net/?retryWrites=true&w=majority&appName=CIS320-App-Cluster"

let client = try MongoClient(
    uri,
    using: elg
)

defer {
    // clean up driver resources
    try? client.syncClose()
    cleanupMongoSwift()

    // shut down EventLoopGroup
    try? elg.syncShutdownGracefully()
}

// print a list of database names
print(try client.listDatabaseNames().wait())

// MongoHelper.swift
func listDatabaseNames(uri: String, eventLoopGroup: EventLoopGroup) throws -> [String] {
    let client = try MongoClient(uri, using: eventLoopGroup)
    defer {
        try? client.syncClose()
        cleanupMongoSwift()
    }
    return try client.listDatabaseNames().wait()
}
