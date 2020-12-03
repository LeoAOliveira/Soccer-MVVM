//
//  PlayerListViewModel.swift
//  Soccer MVVM
//
//  Created by Leonardo Oliveira on 09/09/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import CoreData

protocol PlayerListViewModelDelegate: AnyObject {
    func updateUI()
    func beginUpdates()
    func endUpdates()
    func insertNewPlayerAt(indexPath: IndexPath)
}

final class PlayerListViewModel: NSObject {
    
    weak var delegate: PlayerListViewModelDelegate?
        
    private let coordinator: RootCoordinator
    private let context: NSManagedObjectContext
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Player> = {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Player.modifiedAt, ascending: false)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, 
                                                                  managedObjectContext: context, 
                                                                  sectionNameKeyPath: nil, 
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    var numberOfPlayers: Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    init(coordinator: RootCoordinator, context: NSManagedObjectContext) {
        self.coordinator = coordinator
        self.context = context
    }
    
    func playerNameAt(indexPath: IndexPath) -> String {
        return fetchedResultsController.object(at: indexPath).name ?? ""
    }
    
    func playerNationalityAt(indexPath: IndexPath) -> String {
        return fetchedResultsController.object(at: indexPath).nationality ?? ""
    }
    
    func addPlayer() {
        coordinator.addPlayer()
    }
    
    func fetchPlayers() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension PlayerListViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, 
                    didChange anObject: Any, 
                    at indexPath: IndexPath?, 
                    for type: NSFetchedResultsChangeType, 
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                delegate?.insertNewPlayerAt(indexPath: newIndexPath)
            }
        default:
            break
        }
    }
}

