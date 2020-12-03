//
//  AutoLayout.swift
//  Soccer MVVM
//
//  Created by Leonardo Oliveira on 09/09/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import UIKit

@propertyWrapper final class AutoLayout<T:UIView> {
    
    private lazy var view: T = {
        let view = T(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var wrappedValue: T {
        return view
    }
}
