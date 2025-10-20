//
//  NetworkService.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import Foundation

actor NetworkService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Codable>(from url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode)
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

// MARK: - Network Errors

enum NetworkError: Error {
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
}
