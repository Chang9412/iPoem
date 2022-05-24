//
//  IPNetWorking.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/23.
//

import Foundation



class IPNetWorking<T:Codable> {
    public let session = URLSession.shared
    typealias Completion = (_ data:T?, _ error: Error?) -> Void
    var completion: Completion = {_,_  in }
    
    func request(_ urlString: String, method:String? = "GET", header:[String:String]? = nil, completion: @escaping Completion) {
        guard let url = URL(string: urlString) else { return }
        self.completion = completion
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        if let header = header {
            request.allHTTPHeaderFields = header
        }
        request.httpMethod = method
        let task = session.dataTask(with: request) { data, resp, error in
            if let error = error {
                self.completion(nil, error)
                return
            }
//            guard let data = data else {
//                return
//            }

            let decoder = JSONDecoder()
            
            do {
                let json = try decoder.decode(T.self, from: data!)
                self.completion(json, nil)
            } catch let error {
                print( error)
                self.completion(nil, error)
            }
        }
        task.resume()
    }
}
