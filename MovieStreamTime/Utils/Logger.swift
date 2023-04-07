//
//  Logger.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import Foundation

struct Logger {

    static func log(at line: UInt = #line,
                    from file: StaticString = #file,
                    what message: String,
                    about type: LogType) {

        let date = Date()
        let formatedDate = date.getFormattedDate(format: K.Date.format)
        let fileName = "\(file)".components(separatedBy:"/").last ?? ""

        print("Date: \(formatedDate), Line: \(line), \(fileName): \(message) [.\(type)]")
    }

    static func log(at line: UInt = #line,
                    from file: StaticString = #file,
                    what message: String,
                    over error: Error) {

        let date = Date()
        let formatedDate = date.getFormattedDate(format: K.Date.format)
        let fileName = "\(file)".components(separatedBy:"/").last ?? ""

        print("Date: \(formatedDate), Line: \(line), \(fileName): \(message) - \(error) [.\(LogType.error)]")
    }
}
