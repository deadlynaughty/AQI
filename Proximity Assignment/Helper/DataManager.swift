//
//  DataManager.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 24/11/21.
//

import Foundation
import Combine

enum ApiError: Error {
    case badUrl
    case badResponse
    case parseError
    case wrongFormat
}

class DataManager {
    
    static let shared = DataManager()
    private var subscribers = Set<AnyCancellable>()
    private var session: URLSession
    private var webSocketTask: URLSessionWebSocketTask?
    
    
    init() {
        session = URLSession.init(configuration: URLSessionConfiguration.default)
        session.configuration.timeoutIntervalForRequest = 30
    }
    
    func dataFetch<T: Decodable>(url: String, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL.init(string: url) else {
            DispatchQueue.main.async {
                completion(.failure(ApiError.badUrl))
            }
            return
        }
        session.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [T].self, decoder: JSONDecoder())
            .sink { status in
                switch status {
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } receiveValue: { results in
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            }.store(in: &subscribers)
    }
    
    func continuousDataFetch<T: Decodable>(url: String, dispatchInterval: DispatchTimeInterval, completion: @escaping(Result<[T], Error>) -> Void) {
        guard let url = URL.init(string: url) else {
            DispatchQueue.main.async {
                completion(.failure(ApiError.badUrl))
            }
            return
        }
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        dataReceived(dispatchInterval: dispatchInterval) { (result: Result<[T], Error>) in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    completion(.success(info))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func dataReceived<T: Decodable>(dispatchInterval: DispatchTimeInterval, completion: @escaping(Result<[T], Error>) -> Void) {
        self.webSocketTask?.receive { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            case .success(let message):
                switch message {
                case .data(let data):
                    do {
                        let info = try JSONDecoder().decode([T].self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(info))
                        }
                    }
                    catch (let error) {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                    
                case .string(let message):
                    guard let data = message.data(using: .utf8) else {
                        DispatchQueue.main.async {
                            completion(.failure(ApiError.parseError))
                        }
                        return
                    }
                    do {
                        let info = try JSONDecoder().decode([T].self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(info))
                        }
                    }
                    catch (let error) {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                @unknown default:
                    break
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + dispatchInterval) {
            self.dataReceived(dispatchInterval: dispatchInterval) { (result: Result<[T], Error>) in
                switch result {
                case .success(let info):
                    DispatchQueue.main.async {
                        completion(.success(info))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
}

