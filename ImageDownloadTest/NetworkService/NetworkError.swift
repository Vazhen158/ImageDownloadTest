//
//  NetworkError.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 08.09.2023.
//

import Foundation

enum PhotoDownloadError: LocalizedError {
    case invalidURL
    case invalidHTTPResponse
    case invalidData

    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "The URL provided is invalid."
            case .invalidHTTPResponse:
                return "The server responded with an unexpected status code."
        case .invalidData:
            return "Error while receiving data"
        }
    }
}
