//
//  CoordinatorProtocol.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }

    func start()
}
