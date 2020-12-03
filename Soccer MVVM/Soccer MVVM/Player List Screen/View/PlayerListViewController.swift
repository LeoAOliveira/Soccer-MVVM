//
//  PlayerListViewController.swift
//  Soccer MVVM
//
//  Created by Leonardo Oliveira on 08/09/20.
//  Copyright © 2020 LeonardoAOliveira. All rights reserved.
//

import UIKit

final class PlayerListViewController: UIViewController {
    
    private let viewModel: PlayerListViewModel
    
    @AutoLayout private var tableView: UITableView
    
    init(viewModel: PlayerListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.delegate = self
        
        tableView.register(PlayerListCell.self, forCellReuseIdentifier: PlayerListCell.identifier)
        
        setupTableViewLayout()
        setupNavigationBar()
        
        tableView.backgroundColor = .systemBlue
        
        view.backgroundColor = .systemRed
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.fetchPlayers()
    }
    
    private func setupTableViewLayout() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlayer))
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc private func addPlayer() {
        viewModel.addPlayer()
    }
}

// MARK:- TableView Delegate
extension PlayerListViewController: UITableViewDelegate {
    
}

// MARK:- TableView Data Source
extension PlayerListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPlayers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerListCell.identifier, for: indexPath) as? PlayerListCell else {
            fatalError("PlayerListCell error")
        }
        
        if let textLabel = cell.textLabel {
            textLabel.text = viewModel.playerNameAt(indexPath: indexPath)   
        }
        
        if let detailLabel = cell.detailTextLabel {
            detailLabel.text = viewModel.playerNationalityAt(indexPath: indexPath)   
        }
        
        return cell
    }
}

// MARK:- View Model Delegate
extension PlayerListViewController: PlayerListViewModelDelegate {
    
    func updateUI() {
        
    }
    
    func beginUpdates() {
        tableView.beginUpdates()
    }
    
    func endUpdates() {
        tableView.endUpdates()
    }
    
    func insertNewPlayerAt(indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .fade)
    }
    
}
