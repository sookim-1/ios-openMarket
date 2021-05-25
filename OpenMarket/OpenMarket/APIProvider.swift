//
//  APIProvider.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/25.
//

import Foundation

class APIProvider {

    let session: URLSessionProtocol
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func getViewArticleList<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        let request = URLRequest(url: MakeURL.viewArticleList(1).url) // urlRequest 생성
        let detailRequest = URLRequest(url: MakeURL.viewArticle(1).url)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { data, urlResponse, error in
                guard let response = urlResponse as? HTTPURLResponse,
                      (200...399).contains(response.statusCode) else {
                    completion(.failure(error ?? APIError.responseError(15326)))
                    return
                }

                if let data = data,
                    let entireResponse = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(entireResponse))
                    return
                }
                completion(.failure(APIError.unknownError))
        }

        task.resume()
    }
}
