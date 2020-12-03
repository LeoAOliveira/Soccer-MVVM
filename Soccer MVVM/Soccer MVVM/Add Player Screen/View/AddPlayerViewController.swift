//
//  AddPlayerViewController.swift
//  Soccer MVVM
//
//  Created by Leonardo Oliveira on 14/09/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import UIKit

final class AddPlayerViewController: UIViewController {
    
    @AutoLayout private var nameTextField: UITextField
    @AutoLayout private var nationalityTextField: UITextField
    @AutoLayout private var ageTextField: UITextField
    @AutoLayout private var confirmButton: UIButton
    @AutoLayout private var stackView: UIStackView
    
    private let viewModel: AddPlayerViewModel
    
    init(viewModel: AddPlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStackView()
        
        view.backgroundColor = .systemBackground
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        nameTextField.placeholder = "Name"
        nationalityTextField.placeholder = "Nationality"
        ageTextField.placeholder = "Age"
        
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.tintColor = .systemBackground
        confirmButton.addTarget(self, action: #selector(addPlayer), for: .touchUpInside)
                
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(nationalityTextField)
        stackView.addArrangedSubview(ageTextField)
        stackView.addArrangedSubview(confirmButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    @objc private func addPlayer() {
        viewModel.name = nameTextField.text ?? ""
        viewModel.nationality = nationalityTextField.text ?? ""
        viewModel.age = ageTextField.text  ?? ""
        
        viewModel.addPlayer()
    }
    
}
