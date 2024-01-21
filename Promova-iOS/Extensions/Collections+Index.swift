//
//  Collections+Index.swift
//  Promova-iOS
//
//  Created by antonhoang on 21/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
