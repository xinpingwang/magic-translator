//
//  HttpRequest.swift
//  Magic Translator
//
//  Created by Arestolus Wang on 26/11/2019.
//  Copyright © 2019 Magic Done. All rights reserved.
//

import Foundation
import Promises


class HttpRequest {

    struct HttpResponse {
        var data: Data
        var response: HTTPURLResponse
    }

    private let defaultSession = URLSession(configuration: .default)

    func get(url: String, params: Dictionary<String, String>? = nil) -> Promise<HttpResponse> {
        let promise = Promise<HttpResponse>(on: .main) { fulfill, reject in
            let queryToAppend: String
            if let params = params {
                let queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value) })
                var urlComponents = URLComponents()
                urlComponents.queryItems = queryItems
                queryToAppend = urlComponents.percentEncodedQuery ?? ""
            } else {
                queryToAppend = ""
            }
            let newUrl = url + ((url.firstIndex(of: "?") == nil) ? "?": "&") + queryToAppend
            let request = URLRequest(url: URL(string: newUrl)!)
            // data: The data returned by the server
            // response: An object that provides response metadata, such as HTTP headers and status code. If you are making an HTTP or HTTPS request, the returned object is actually an HTTPURLResponse object.
            // error: An error object that indicates why the request failed, or nil if the request was successful.
            let dataTask = self.defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    reject(error)
                } else {
                    let httpResponse = HttpResponse(data: data!, response: response! as! HTTPURLResponse)
                    fulfill(httpResponse)
                }
            })
            // start the task
            dataTask.resume()
        }
        return promise
    }

}
