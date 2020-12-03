//
//  RootCoordinator.swift
//  Soccer MVVM
//
//  Created by Leonardo Oliveira on 15/09/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import UIKit

final class RootCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    private let coreDataManager: CoreDataManager
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManager) {
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
    }
    
    func start() {
        let playerListViewModel = PlayerListViewModel(coordinator: self, context: coreDataManager.mainContext)
        let playerListViewController = PlayerListViewController(viewModel: playerListViewModel)
        
        navigationController.pushViewController(playerListViewController, animated: false)
    }
    
    func addPlayer() {
        let addPlayerViewModel = AddPlayerViewModel(coordinator: self, context: coreDataManager.mainContext)
        let addPlayerViewController = AddPlayerViewController(viewModel: addPlayerViewModel)
        
        navigationController.pushViewController(addPlayerViewController, animated: true)
    }
    
    func didFinishAddingPlayer() {
        navigationController.popViewController(animated: true)
    }
    
    
}
