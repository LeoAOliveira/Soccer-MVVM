//
//  AddPlayerViewModel.swift
//  Soccer MVVM
//
//  Created by Leonardo Oliveira on 24/09/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import CoreData

final class AddPlayerViewModel {
    
    var name: String = ""
    var nationality: String = ""
    var age: String = ""
    
    private let coordinator: RootCoordinator
    private let context: NSManagedObjectContext
    
    init(coordinator: RootCoordinator, context: NSManagedObjectContext) {
        self.coordinator = coordinator
        self.context = context
    }
    
    func addPlayer() {
        
        let player = Player(context: context)
        player.name = name
        player.nationality = nationality
        player.age = age
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        coordinator.didFinishAddingPlayer()
    }
}
