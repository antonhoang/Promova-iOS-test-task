//
//  Enviroment.swift
//  Promova-iOS
//
//  Created by antonhoang on 21/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

protocol EnviromentProtocol {
    var network: NetworkProtocol { get }
}

class Enviroment: EnviromentProtocol {
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
}
