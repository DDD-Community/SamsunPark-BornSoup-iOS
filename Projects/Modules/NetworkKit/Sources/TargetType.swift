//
//  TargetType.swift
//  NetworkKit
//
//  Created by 신의연 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Alamofire
import KeychainAccess

import Foundation

public protocol TargetType: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
}

public extension TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://oneul.store") else {
            fatalError("baseURL could not be configured")
        }
        return url
    }
    
    var headers: HTTPHeaders? {
        return HTTPHeaders(
            arrayLiteral: HTTPHeader.authorization(bearerToken: (try? Keychain().get("ACCESS_TOKEN")) ?? ""),
            HTTPHeader.contentType("application/json"),
            HTTPHeader.acceptLanguage(Locale.current.identifier)
        )
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(self.path))
        urlRequest.method = self.method
        
        if let headers {
            urlRequest.headers = headers
        }
        
        if let url = urlRequest.url, let cookies = HTTPCookieStorage.shared.cookies(for: url) {
            let cookie = HTTPCookie.requestHeaderFields(with: cookies)
            for (key, value) in cookie {
                urlRequest.headers.add(name: key, value: value)
            }
        }
        return try JSONEncoding.default.encode(urlRequest, with: self.parameters)
    }
    
    func asQueryURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(self.path))
        var componets = URLComponents(string: baseURL.absoluteString)
        componets?.path = path
        urlRequest.method = method
        
        if let headers {
            urlRequest.headers = headers
        }
        
        if let url = urlRequest.url, let cookies = HTTPCookieStorage.shared.cookies(for: url) {
            let cookie = HTTPCookie.requestHeaderFields(with: cookies)
            for (key, value) in cookie {
                urlRequest.headers.add(name: key, value: value)
            }
        }
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}

public extension URLRequest {
    func log() {
#if DEBUG
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlAsString = self.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)
        let method = self.httpMethod != nil ? "\(self.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        let encoding = "\(urlComponents?.encodedHost ?? "")"
        var output = """
       \(urlAsString) \n\n
       \(method) \(path)?\(query) HTTP/1.1 \n
       \(encoding)
       HOST: \(host)\n
       """
        for (key,value) in self.allHTTPHeaderFields ?? [:] {
            output += "\(key): \(value) \n"
        }
        if let body = self.httpBody {
            output += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }
        print(output)
#endif
    }
}
