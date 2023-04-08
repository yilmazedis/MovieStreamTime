//
//  ManagerFail.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

enum ManagerFail: Error {
    case data
    case error
    case response
    case statusCode
    case decode
}
