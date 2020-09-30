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

    // MARK: - Lifecycle -

    init(view: MainViewInterface, interactor: MainInteractorInterface, wireframe: MainWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension MainPresenter: MainPresenterInterface {
}
