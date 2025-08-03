//
//  APIClient.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import Alamofire
import RxSwift

public final class APIClient {
    static func request<T: Decodable>(
        url: URLRequestConvertible,
        forModel model: T.Type
    ) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(url)
                .validate()
                .responseData { response in
                    guard let statusCode = response.response?.statusCode else {
                        observer.onError(APIError.noInternetConnection)
                        return
                    }

                    switch statusCode {
                    case 200..<300:
                        guard let data = response.data else {
                            observer.onError(APIError.dataFailed)
                            return
                        }

                        do {
                            let result = try JSONDecoder().decode(model.self, from: data)
                            observer.onNext(result)
                            observer.onCompleted()
                        } catch {
                            observer.onError(APIError.decodeFailed)
                        }

                    case 400..<500:
                        observer.onError(APIError.networkFailed)

                    default:
                        observer.onError(APIError.networkFailed)
                    }
                }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}

enum APIError: Error {
    case decodeFailed
    case dataFailed
    case networkFailed
    case urlNotFound
    case defaultError
    case noInternetConnection
    
    var errorDescription: String {
        switch self {
        case .dataFailed: return "Failed to convert data"
        case .networkFailed: return "Failed to connect to network"
        case .decodeFailed: return "Failed to decode json"
        case .urlNotFound: return "URL not found"
        case .defaultError: return "Error has been happened"
        case .noInternetConnection: return "No internet connection"
        }
    }
}
