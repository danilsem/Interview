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
    func showDetailInfo(for item: PryanikItem) {
        let alert = UIAlertController(title: "Информация", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        alert.addAction(UIAlertAction(title: "Отмена", style: .destructive))
        
        switch item.name {
            
        case .hz:
            guard let hzItem = item.asHzItem() else { break }
            alert.message = "\(item.name.rawValue)\n\(hzItem.name)"
        case .picture:
            guard let pictureItem = item.asPictureItem() else { break }
            alert.message = "\(item.name.rawValue)\n\(pictureItem.text)"
        case .selector:
            guard let selectorItem = item.asSelectorItem() else { break }
            
            for selectedItem in selectorItem.variants {
                if selectorItem.selected == selectedItem.id {
                    alert.message = "\(item.name.rawValue)\n\(selectedItem.text)"
                }
            }
        }
        self.viewController.present(alert, animated: true)
    }
}
