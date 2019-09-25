//
//  MovieController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/24/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

enum NetworkError: Error {
	case otherError
	case badData
	case noDecode
	case noEncode
	case badResponse
}

class MovieController {

	let upcomingBaseUrl = URL(string: "https://api.themoviedb.org/3/movie/upcoming")!
	let topRatedBaseUrl = URL(string: "https://api.themoviedb.org/3/movie/top_rated")!
	let nowPlayingBaseUrl = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
	let apiQueryItem = URLQueryItem(name: "api_key", value: .movieDatabaseApiKey)


	// MARK: - Fetch Movies Functions
	func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
		var urlComponents = URLComponents(url: nowPlayingBaseUrl, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = [apiQueryItem]
		fetchMovieHelper(urlComponents: urlComponents, completion: completion)
	}

	func fetchTopRatedMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
		var urlComponents = URLComponents(url: topRatedBaseUrl, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = [apiQueryItem]
		fetchMovieHelper(urlComponents: urlComponents, completion: completion)
	}

	func fetchUpcomingMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
		var urlComponents = URLComponents(url: upcomingBaseUrl, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = [apiQueryItem]
		fetchMovieHelper(urlComponents: urlComponents, completion: completion)
	}

	private func fetchMovieHelper(urlComponents: URLComponents?, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
		guard let requestUrl = urlComponents?.url else {
			NSLog("Request URL is nil")
			completion(.failure(.otherError))
			return
		}

		var request = URLRequest(url: requestUrl)
		request.httpMethod = HTTPMethod.get.rawValue

		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let error = error {
				NSLog("Error fetching data: \(error)")
				completion(.failure(.otherError))
				return
			}

			guard let data = data else {
				completion(.failure(.badData))
				return
			}

			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let results = try decoder.decode(MoviesResponse.self, from: data)
				completion(.success(results.results))
			} catch {
				NSLog("Error decoding results: \(error)")
				completion(.failure(.noDecode))
			}
		}.resume()
	}
}
