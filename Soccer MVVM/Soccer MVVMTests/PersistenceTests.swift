//
//  PersistenceTests.swift
//  Soccer MVVMTests
//
//  Created by Leonardo Oliveira on 28/09/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import XCTest
@testable import Soccer_MVVM

final class PersistenceTests: XCTestCase {
    
    var sut: Persistence!
    
    override func setUp() {
        super.setUp()
        sut = Persistence()
    }
    
    func testFetch() {
        
        let player1 = Player(name: "Rogerio Ceni", nationality: "Brasileiro", age: 45)
        let player2 = Player(name: "Kaka", nationality: "Brasileiro", age: 40)
        let player3 = Player(name: "Luis Fabiano", nationality: "Brasileiro", age: 40)
        
        sut.addPlayer(player1)
        sut.addPlayer(player2)
        sut.addPlayer(player3)
        
        XCTAssertEqual(sut.fetch(), [player1, player2, player3])
    }
    
    func testAddPlayer() {
        
        XCTAssertTrue(sut.fetch().isEmpty)
        
        let player = Player(name: "Rogerio Ceni", nationality: "Brasileiro", age: 45)
        sut.addPlayer(player)
        
        let players = sut.fetch()
        
        XCTAssertEqual(players.count, 1)
        XCTAssertNotNil(players.first)
        XCTAssertEqual(players.first!, player)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
}
