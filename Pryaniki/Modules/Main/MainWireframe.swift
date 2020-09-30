//
//  MainWireframe.swift
//  Pryaniki
//
//  Created by Admin on 30.09.2020.
//  Copyright (c) 2020 Danil Semenov. All rights reserved.

import UIKit

final class MainWireframe: BaseWireframe {

    init() {
        let moduleViewController = MainViewController()
        super.init(viewController: moduleViewController)

        let interactor = MainInteractor()
        let presenter = MainPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension MainWireframe: MainWireframeInterface {
}
