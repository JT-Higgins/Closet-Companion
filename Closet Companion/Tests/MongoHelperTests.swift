// MongoHelperTests.swift
import XCTest
import MongoSwift
import NIO
@testable import YourModuleNameHere

final class MongoHelperTests: XCTestCase {

    var elg: EventLoopGroup!

    override func setUp() {
        super.setUp()
        elg = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    }

    override func tearDown() {
        try? elg.syncShutdownGracefully()
        super.tearDown()
    }

    func testListDatabaseNames() throws {
        let uri = "mongodb+srv://admin:<Admin1234!>@cis320-app-cluster.jggymwr.mongodb.net/?retryWrites=true&w=majority&appName=CIS320-App-Cluster"

        let dbs = try listDatabaseNames(uri: uri, eventLoopGroup: elg)
        
        // Assert that it returns at least one database
        XCTAssertFalse(dbs.isEmpty, "Expected at least one database to be returned.")
    }
}
