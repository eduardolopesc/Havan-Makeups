//
//  ImageServiceProtocol.swift
//  Havan
//
//  Created by Eduardo on 24/05/23.
//

import UIKit

protocol ImageServiceProtocol {
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}
