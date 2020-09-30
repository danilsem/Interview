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
        
        tableView.register(TextCell.nib, forCellReuseIdentifier: TextCell.identifier)
        tableView.register(ImageCell.nib, forCellReuseIdentifier: ImageCell.identifier)
        tableView.register(SelectorCell.nib, forCellReuseIdentifier: SelectorCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()

    var presenter: MainPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupUI()
        setupLayout()
        presenter.loadData()
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
    func updateTable() {
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.tableViewRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = presenter.tableData[indexPath.row]
        switch item.name {
        case .hz:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath) as! TextCell
            cell.configure(with: item)
            return cell
        case .picture:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
            cell.configure(with: item)
            return cell
        case .selector:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectorCell.identifier, for: indexPath) as! SelectorCell
            cell.configure(with: item)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(row: indexPath.row)
        tableView.selectRow(at: nil, animated: false, scrollPosition: .none)
    }
}
