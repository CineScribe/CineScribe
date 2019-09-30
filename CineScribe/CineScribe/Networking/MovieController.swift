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
	case badRequestURL
}

class MovieController {

	public static let shared = MovieController()

	private let castBaseURL = URL(string: "https://api.themoviedb.org/3/movie")!
	private let upcomingBaseUrl = URL(string: "https://api.themoviedb.org/3/movie/upcoming")!
	private let popularBaseUrl = URL(string: "https://api.themoviedb.org/3/movie/popular")!
	private let nowPlayingBaseUrl = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
	private let searchMovieBaseUrl = URL(string: "https://api.themoviedb.org/3/search/movie")!
	private let apiQueryItem = URLQueryItem(name: "api_key", value: .movieDatabaseApiKey)

    let urlSession = URLSession.shared
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

	// MARK: - Movies Functions

    let languageQuery = URLQueryItem(name: "language", value: "en-US")
    let regionQuery = URLQueryItem(name: "region", value: "US")
    let adultQuery = URLQueryItem(name: "include_adult", value: "false")

	func fetchNowPlayingMovies(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void) {
		var urlComponents = URLComponents(url: nowPlayingBaseUrl, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = [apiQueryItem, regionQuery, languageQuery, adultQuery]
		fetchMovieHelper(urlComponents: urlComponents, completion: completion)
	}

	func fetchPopularMovies(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void) {
		var urlComponents = URLComponents(url: popularBaseUrl, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = [apiQueryItem, regionQuery, languageQuery, adultQuery]
		fetchMovieHelper(urlComponents: urlComponents, completion: completion)
	}

	func fetchUpcomingMovies(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void) {
		var urlComponents = URLComponents(url: upcomingBaseUrl, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = [apiQueryItem, regionQuery, languageQuery, adultQuery]
		fetchMovieHelper(urlComponents: urlComponents, completion: completion)
	}

    func searchDatabse(for movie: String, completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void) {
        var urlComponents = URLComponents(url: searchMovieBaseUrl, resolvingAgainstBaseURL: true)
        let searchQuery = URLQueryItem(name: "query", value: movie)

        urlComponents?.queryItems = [apiQueryItem, searchQuery, regionQuery, languageQuery, adultQuery]
        fetchMovieHelper(urlComponents: urlComponents, completion: completion)
    }

	private func fetchMovieHelper(urlComponents: URLComponents?, completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void) {
		guard let requestUrl = urlComponents?.url else {
			NSLog("Request URL is nil")
			completion(.failure(.otherError))
			return
		}

		var request = URLRequest(url: requestUrl)
		request.httpMethod = HTTPMethod.get.rawValue

		URLSession.shared.dataTask(with: request) { data, _, error in
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
                let results = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
				completion(.success(results))
			} catch {
				NSLog("Error decoding results: \(error)")
				completion(.failure(.noDecode))
			}
		}.resume()
	}


	// MARK: - Credits

	func getCredits(for movie: Movie, completion: @escaping (Result<MovieCreditResponse, NetworkError>) -> Void) {
		getCredits(with: movie.id, completion: completion)
	}

	func getCredits(with movieID: Int, completion: @escaping (Result<MovieCreditResponse, NetworkError>) -> Void) {

		let creditURL = castBaseURL.appendingPathComponent("\(movieID)").appendingPathComponent("credits")

		var urlComponents = URLComponents(url: creditURL, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = [apiQueryItem]

		guard let requestUrl = urlComponents?.url else {
			NSLog("Request URL is nil")
			completion(.failure(.badRequestURL))
			return
		}

		var request = URLRequest(url: requestUrl)
		request.httpMethod = HTTPMethod.get.rawValue

		URLSession.shared.dataTask(with: request) { data, _, error in
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
                let results = try self.jsonDecoder.decode(MovieCreditResponse.self, from: data)
				completion(.success(results))
			} catch {
				NSLog("Error decoding results for type MovieCreditResponse: \(error)")
				completion(.failure(.noDecode))
			}
		}.resume()
	}
}
