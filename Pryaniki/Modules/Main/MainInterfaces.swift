//
//  MainInterfaces.swift
//  Pryaniki
//
//  Created by Admin on 30.09.2020.
//  Copyright (c) 2020 Danil Semenov. All rights reserved.

import UIKit

protocol MainWireframeInterface: WireframeInterface {
    func showDetailInfo(for item: PryanikItem)
}

protocol MainViewInterface: ViewInterface {
    func updateTable()
}

protocol MainPresenterInterface {
    var tableData: [PryanikItem] { get }
    var tableViewRows: Int { get }
    func viewDidLoad()
    func loadData()
    func didSelectRowAt(row: Int)
}

protocol MainInteractorInterface {
    func getPryanikData(completion: @escaping (Result<[PryanikItem], PryanikServiceError>) -> ())
}
