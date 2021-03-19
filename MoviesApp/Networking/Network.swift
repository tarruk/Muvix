//
//  Network.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift




enum NetworkingError: Error {
    case invalidURL
    case emptyResponse
    case timeOutRequest
    case decodingError
    case undefined
    
    func getMessage() -> String {
        switch self {
        case .timeOutRequest:
            return "Time out request"
        case .undefined:
            return "Undefined Error"
        case .decodingError:
            return "Decoding Error"
        default:
            return ""
        }
    }
}


struct RequestData {
    
    var path        : String
    var method      : HTTPMethod
    var parameters  : [String:Any?] = [:]
    var headers     : HTTPHeaders? = [HTTPHeader(name: "Content-Type", value: "application/json;charset=utf-8")]
    
    func normalizedParameters() -> [String: Any] {
        var params: [String: Any] = [:]
        parameters.forEach { parameter in
            guard let value = parameter.value else {
                return
            }
            params[parameter.key] = value
        }
        return params
    }
}

protocol NetworkProtocol {
    
    associatedtype ResponseType: Codable
    var request: RequestData { get }
    var path: Request { get }
    
}

extension NetworkProtocol {
    
    func printRequest(from request: RequestData) {
        printLine()
        print("Dispatch to  => \(request.path)")
        print("Method       => \(request.method.rawValue)")
        print("Parameters   =>")
        printJSON(from: request.normalizedParameters())
    }
    
    func printLine() {
        print("----------------------------------------------")
    }
    
    func getErrorType(from statusCode: Int) -> NetworkingError {
        switch statusCode {
        case 408  : return .timeOutRequest
        default     : return .undefined
        }
    }
    
    func printJSON(from dict: [String: Any]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            print(decoded)
        } catch {
            print(error.localizedDescription)
        }

        
    }
    
    func printJSON(from responseValue: ResponseType) {
        print("Response     =>")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(responseValue)
        print(String(data: data, encoding: .utf8)!)
        printLine()
        
    }
    
    func printStatusCode(from response: AFDataResponse<Any>){
        if let statusCode = response.response?.statusCode {
            print("Status code  => \(statusCode)")
        }
    }

    
    func rx_dispatch() -> Observable<ResponseType>{
        return Observable<ResponseType>.create { observer in
            AF.request(
                request.path,
                method: request.method,
                parameters: request.normalizedParameters(),
                headers: request.headers
            ).responseJSON { (response: AFDataResponse<Any>) in
                guard let data = response.data,
                      let statusCode = response.response?.statusCode else {
                    observer.onError(NetworkingError.emptyResponse)
                    return
                }
            
                printRequest(from: request)
                printStatusCode(from: response)
                do {
                    let responseValue = try JSONDecoder().decode(ResponseType.self, from: data)
                    
                    if response.response?.statusCode == 200 {
                        printJSON(from: responseValue)
                        observer.onNext(responseValue)
                        observer.onCompleted()
                        
                    } else {
                        print("-.-.-.- Networking Error -.-.-.-")
                        print("StatusCode       => \(statusCode)")
                        print("Message          => \(getErrorType(from: statusCode).getMessage())")
                    }
                    
                
                } catch {
                    print(NetworkingError.decodingError.getMessage())
                    observer.onError(NetworkingError.decodingError)
                   
                }
            }
            return Disposables.create()
        }
        
    }
    
   
    
    
}
