//
//  Player.swift
//  Soccer MVVM
//
//  Created by Leonardo Oliveira on 09/09/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import Foundation

struct PlayerModel {
    
    let name: String
    let nationality: String
    let age: Int
}

extension PlayerModel: Equatable {
    
    static func ==(lhs: PlayerModel, rhs: PlayerModel) -> Bool {
        return lhs.name == rhs.name && 
            lhs.nationality == rhs.nationality && 
            lhs.age == rhs.age
    }
}
