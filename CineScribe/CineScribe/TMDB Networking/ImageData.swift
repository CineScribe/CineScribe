//
//  ImageData.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

final class ImageData {

	private var imageCache = NSCache<NSString, AnyObject>()

	// MARK: - Fetch Images

	public func fetchPosterImage(for movie: Movie, completion: @escaping (Error?, UIImage?) -> Void) {
		let posterUrlString = movie.posterURL.absoluteString
		if let image = imageCache.object(forKey: posterUrlString as NSString) as? UIImage {
			completion(nil, image)
			return
		}

		URLSession.shared.dataTask(with: movie.posterURL) { (data, _, error) in
			if let error = error {
				completion(error, nil)
				return
			}

			guard let data = data else { fatalError("Can't unwrap data for image") }

			DispatchQueue.main.async {
				if let image = UIImage(data: data) {
					self.imageCache.setObject(image, forKey: posterUrlString as NSString)
					completion(nil, image)
				}
			}
		}.resume()
	}
}
