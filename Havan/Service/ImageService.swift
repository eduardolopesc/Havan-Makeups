//
//  ImageService.swift
//  Havan
//
//  Created by Eduardo on 24/05/23.
//

import Foundation
import Alamofire

class ImageService: ImageServiceProtocol {
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        AF.download(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NSError(domain: "ImageDownloadError", code: -1, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
