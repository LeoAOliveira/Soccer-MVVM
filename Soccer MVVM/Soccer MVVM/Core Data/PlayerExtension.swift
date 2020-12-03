//
//  PlayerExtension.swift
//  Soccer MVVM
//
//  Created by Leonardo Oliveira on 02/11/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import CoreData

extension Player {
    
    public override func awakeFromInsert() {
        self.createdAt = Date()
    }
}
