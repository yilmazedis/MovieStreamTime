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
        
        var icon = ""
        switch type {
        case .error:
            icon = "\u{1F6A8}"
        case .info:
            icon = "\u{1F481}"
        case .debug:
            icon = "\u{1FAB2}"
        }
        
        print("\(icon) Date: \(formatedDate), Line: \(line), \(fileName): \u{1F449} \(message) [.\(type)]")
    }

    static func log(at line: UInt = #line,
                    from file: StaticString = #file,
                    what message: String,
                    over error: Error) {

        let date = Date()
        let formatedDate = date.getFormattedDate(format: K.Date.format)
        let fileName = "\(file)".components(separatedBy:"/").last ?? ""

        let icon = "\u{1F6A8}"
        print("\(icon) Date: \(formatedDate), Line: \(line), \(fileName): \u{1F449} \(message) - \(error) [.\(LogType.error)]")
    }
}
