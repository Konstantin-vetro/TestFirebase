//
//  NetworkManager.swift
//  TestFirebase
//
//  Created by Гость on 30.10.2025.
//

import UIKit

protocol NetworkManagerProtocol {
    func fetchData() async throws -> [UserModel]
    func downloadImage() async -> UIImage?
}

enum NetworkError: Error {
    case badURL
    case badServerResponse
    case decoderError
}

enum ImageError: Error {
    case badImage
}

final class NetworkManager: NetworkManagerProtocol {
    private let address = "https://jsonplaceholder.typicode.com/users"
    private let imageAddress = "https://i.pinimg.com/236x/22/b9/6a/22b96a7a120f6ec2b411ee24964fe7e5.jpg"

    func fetchData() async throws -> [UserModel] {
        guard let url = URL(string: address) else { throw NetworkError.badURL }
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else { throw NetworkError.badServerResponse }

        do {
            let users = try JSONDecoder().decode([UserModel].self, from: data)
            return users
        } catch {
            throw NetworkError.decoderError
        }
    }

    func downloadImage() async -> UIImage? {
        guard let url = URL(string: imageAddress) else { return nil }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else { throw NetworkError.badServerResponse }

            return UIImage(data: data)
        } catch {
            print("Ошибка загрузки \(error)")
            return nil
        }
    }
}
