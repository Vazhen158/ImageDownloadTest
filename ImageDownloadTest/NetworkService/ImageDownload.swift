//
//  ImageDownload.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 08.09.2023.
//

import Foundation

enum APIEndpoints {
    static let photos = "https://jsonplaceholder.typicode.com/photos"
}

class ImageDownload {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func downloadData(completion: @escaping (Result<[ImageDownloadEntity], Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.photos) else {
            dispatchToMain(.failure(PhotoDownloadError.invalidURL), completion: completion)
            return
        }
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            self?.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }
    
    private func handleResponse(data: Data?,
                                response: URLResponse?,
                                error: Error?,
                                completion: @escaping (Result<[ImageDownloadEntity], Error>) -> Void) {
        if let error = error {
            dispatchToMain(.failure(error), completion: completion)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            dispatchToMain(.failure(PhotoDownloadError.invalidHTTPResponse), completion: completion)
            return
        }
        
        guard let data = data else {
            dispatchToMain(.failure(PhotoDownloadError.invalidData), completion: completion)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let photos = try decoder.decode([ImageDownloadEntity].self, from: data)
            dispatchToMain(.success(photos), completion: completion)
        } catch {
            dispatchToMain(.failure(error), completion: completion)
        }
    }
    
    private func dispatchToMain<T>(_ result: Result<T, Error>,
                                   completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
