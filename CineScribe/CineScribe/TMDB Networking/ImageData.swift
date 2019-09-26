//
//  ImageData.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

enum ImageStyle {
	case poster
	case backdrop
}

final class ImageData {

	public static let shared = ImageData()

	private var imageCache = NSCache<NSString, AnyObject>()

	// MARK: - Fetch Images

	public func fetchImage(for movie: Movie, imageStyle: ImageStyle, completion: @escaping (Error?, UIImage?) -> Void) {

		let imageUrlString: String = {
			if imageStyle == .poster {
				return movie.posterURL.absoluteString
			} else {
				return movie.backdropURL.absoluteString
			}
		}()

//		let posterUrlString = movie.posterURL.absoluteString
		if let image = imageCache.object(forKey: imageUrlString as NSString) as? UIImage {
			completion(nil, image)
			return
		}

		let imageURL: URL = {
			if imageStyle == .poster {
				return movie.posterURL
			} else {
				return movie.backdropURL
			}
		}()

		URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
			if let error = error {
				completion(error, nil)
				return
			}

			guard let data = data else { fatalError("Can't unwrap data for image") }

			DispatchQueue.main.async {
				if let image = UIImage(data: data) {
					self.imageCache.setObject(image, forKey: imageUrlString as NSString)
					completion(nil, image)
				}
			}
		}.resume()
	}


	public func fetchImage(for castMember: MovieCast, completion: @escaping (Error?, UIImage?) -> Void) {

		guard let url = castMember.profileURL else { return }

		if let image = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
			completion(nil, image)
			return
		}

		URLSession.shared.dataTask(with: url) { (data, _, error) in
			if let error = error {
				completion(error, nil)
				return
			}

			guard let data = data else { fatalError("Can't unwrap image for Cast Member") }

			DispatchQueue.main.async {
				if let image = UIImage(data: data) {
					self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
					completion(nil, image)
				}
			}
		}.resume()
	}


	public func fetchImage(for crewMember: MovieCrew, completion: @escaping (Error?, UIImage?) -> Void) {

		guard let url = crewMember.profileURL else { return }

		if let image = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
			completion(nil, image)
			return
		}

		URLSession.shared.dataTask(with: url) { (data, _, error) in
			if let error = error {
				completion(error, nil)
				return
			}

			guard let data = data else { fatalError("Can't unwrap image Crew Member") }

			DispatchQueue.main.async {
				if let image = UIImage(data: data) {
					self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
					completion(nil, image)
				}
			}
		}.resume()
	}
}
