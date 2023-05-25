//
//  DetailViewModelProtocol.swift
//  Havan
//
//  Created by Eduardo on 25/05/23.
//

import UIKit

protocol DetailViewModelProtocol {
    var product: Product { get }
    var updateView: (() -> Void)? { get set }
    var loadImage: ((UIImage?) -> Void)? { get set }
    func favoriteToggle()
    func viewEntity() -> DetailViewEntity
}
