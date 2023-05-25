//
//  FavoriteViewProtocol.swift
//  Havan
//
//  Created by Eduardo on 25/05/23.
//

import UIKit

protocol FavoriteViewProtocol: UIView {
    var didTapCell: ((Product) -> Void)? { get set }
    func reloadView(with products: [Product])
}
