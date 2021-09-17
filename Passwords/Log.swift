//
//  Log.swift
//  Passwords
//
//  Created by Eugene G on 9/13/21.
//

import Foundation

public class Log: NSObject {

    private static var textLog = TextLog()

    public class func debug<T>(_ message: T, filename: String = #file, line: Int = #line, function: String = #function) {
        let fileString = filename as NSString
        let fileLastPathComponent = fileString.lastPathComponent as NSString
        let msg = "<Debug>\t\(Date()):\n[file: \((fileLastPathComponent))] [line: \(line)] [function: \(function)] \n\(message)\n"
        #if DEBUG
        print(msg)
        textLog.write("\(msg)") // write to logs.txt file
        #else
        #endif
    }

    public class func error<T>(_ message: T, filename: String = #file, line: Int = #line, function: String = #function) {
        let fileString = filename as NSString
        let fileLastPathComponent = fileString.lastPathComponent as NSString
        let msg = "🚫<Error>\t\(Date()):\n[file: \((fileLastPathComponent))] [line: \(line)] [function: \(function)] \n\(message)\n"
        #if DEBUG
            print(msg)
            textLog.write("\(msg)") // write to logs.txt file
        #else
        
        #endif
    }

}
