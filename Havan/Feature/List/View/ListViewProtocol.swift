//
//  ListViewProtocol.swift
//  Havan
//
//  Created by Eduardo on 25/05/23.
//

import UIKit

protocol ListViewProtocol: UIView {
    var didTapNumericButton: (() -> Void)? { get set }
    var didTapAlphabeticButton: (() -> Void)? { get set }
    var didTapClearButton: (() -> Void)? { get set }
    var didTapCell: ((Product) -> Void)? { get set }
    func reloadView(with products: [Product])
}
