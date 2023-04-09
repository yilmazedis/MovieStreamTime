//
//  Logger.swift
//  MovieStreamTime
//
//  Created by yilmaz on 7.04.2023.
//

import OSLog

struct FastLogger {

    static func log(at line: UInt = #line,
                    from file: StaticString = #file,
                    what message: String,
                    about type: OSLogType) {

        let fileName = "\(file)".components(separatedBy:"/").last ?? ""
        
        var icon = ""
        switch type {
        case .error:
            icon = "\u{1F6A8}"
        case .debug:
            icon = "\u{1FAB2}"
        default:
            icon = "\u{1F481}"
        }
        
        let log = Logger.init(subsystem: Bundle.main.bundleIdentifier!, category: fileName)
        log.log(level: type, "\(icon) \(message)")
    }

    static func log(at line: UInt = #line,
                    from file: StaticString = #file,
                    what message: String,
                    over error: Error) {

        let fileName = "\(file)".components(separatedBy:"/").last ?? ""
        
        let icon = "\u{1F6A8}"
        let log = Logger.init(subsystem: Bundle.main.bundleIdentifier!, category: fileName)
        log.log(level: .error, "\(icon) \(message)")
    }
}
