//
//  MainPresenter.swift
//  Pryaniki
//
//  Created by Admin on 30.09.2020.
//  Copyright (c) 2020 Danil Semenov. All rights reserved.

import Foundation

final class MainPresenter {

    // MARK: - Private properties -

    private unowned let view: MainViewInterface
    private let interactor: MainInteractorInterface
    private let wireframe: MainWireframeInterface
    
    private var pryanikArray: [PryanikItem] = []

    // MARK: - Lifecycle -

    init(view: MainViewInterface, interactor: MainInteractorInterface, wireframe: MainWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension MainPresenter: MainPresenterInterface {
    
    var tableData: [PryanikItem] {
        pryanikArray
    }
    
    var tableViewRows: Int {
        pryanikArray.count
    }
    
    func viewDidLoad() {
        loadData()
    }
    
    func loadData() {
        interactor.getPryanikData { [weak self] (result) in
            switch result {
            case .success(let array):
                self?.pryanikArray = array
                self?.view.updateTable()
            case .failure(_):
                break
            }
        }
    }
    
    func didSelectRowAt(row: Int) {
        let item = pryanikArray[row]
        wireframe.showDetailInfo(for: item)
    }
}
