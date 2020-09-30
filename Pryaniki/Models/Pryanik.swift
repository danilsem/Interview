//
//  Pryanik.swift
//  Pryaniki
//
//  Created by Admin on 30.09.2020.
//  Copyright © 2020 Danil Semenov. All rights reserved.
//

import Foundation

enum PryanikViewType: String {
    case hz = "hz"
    case picture = "picture"
    case selector = "selector"
}

struct PryanikResponse {
    let data: [PryanikItem]
    let view: [PryanikViewType]
}

struct PryanikItem {
    let name: PryanikViewType
    let data: Any
    
    func asHzItem() throws -> PryanikHzItem? {
        return data as? PryanikHzItem
    }
    
    func asPictureItem() throws -> PryanikPictureItem? {
        return data as? PryanikPictureItem
    }
    
    func asSelectorItem() throws -> PryanikSelectorItem? {
        return data as? PryanikSelectorItem
    }
}

struct PryanikHzItem {
    let name: String
}

struct PryanikPictureItem {
    let text: String
    let url: String
}

struct PryanikSelectorItem {
    struct Variant {
        let id: Int
        let text: String
    }
    let selected: Int
    let variants: Array<Variant>
}
