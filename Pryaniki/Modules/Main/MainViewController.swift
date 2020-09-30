//
//  MainViewController.swift
//  Pryaniki
//
//  Created by Admin on 30.09.2020.
//  Copyright (c) 2020 Danil Semenov. All rights reserved.

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Public properties -
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return tableView
    }()

    var presenter: MainPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = PryanikService()
        
        service.loadPryanikData { (result) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
        
        setupUI()
        setupLayout()
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - Extensions -

extension MainViewController: MainViewInterface {
}
