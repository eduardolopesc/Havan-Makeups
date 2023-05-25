//
//  DetailViewProtocol.swift
//  Havan
//
//  Created by Eduardo on 25/05/23.
//

import UIKit

protocol DetailViewProtocol: UIView {
    func updateView(entity: DetailViewEntity)
    func updateImage(_ image: UIImage?)
}
