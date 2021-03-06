//
//  Coordinator.swift
//  Soccer MVVM
//
//  Created by Leonardo Oliveira on 15/09/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get }
    
    func start()
}
