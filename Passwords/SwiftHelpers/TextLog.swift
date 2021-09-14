//
//  TextLog.swift
//  Passwords
//
//  Created by Eugene G on 9/13/21.
//

import Foundation

/**
 Note:
 
        Struct for wtiting debug build logs to files in 'Documents/logs' folder
        Value type used to write files syncronously with custom `textLog.queue` thread
        Used only used in DEBUG builds
        Each file is a day of logs.
 */

struct TextLog: TextOutputStream {
    
    let textLogQueue = DispatchQueue(label: "textLog.queue", qos: .background)
    static let filesMax = 7
    
    // MARK: - Public
    
    mutating func write(_ string: String) {
        
        #if RELEASE
        return
        #else
        #endif
        
        textLogQueue.sync {
            
            let urls = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)
            guard let documentsFolder = urls.first else {
                let err = "🚫Can't get documents folder"
                print(err)
                return
            }
            let logsFolderPath = documentsFolder.appendingPathComponent("logs")
            if !self.checkFolderExists(folderPath: logsFolderPath) {
                return
            }
            
            self.deleteOldFiles(logsFolder: logsFolderPath)

            let logFilePath = self.getLogFilePath(logsFolder: logsFolderPath)
            self.checkFileExists(fileUrl: logFilePath)
            
            do {
                /// Appends the given string to the stream.
                let handle = try FileHandle(forWritingTo: logFilePath)
                handle.seekToEndOfFile()
                handle.write(string.data(using: .utf8)!)
                handle.closeFile()
            } catch {
                let err = "🚫🔴Unale to write to file \(error.localizedDescription)"
                print(err)
            }
        }
    }
    
    // MARK: - Private
    
    mutating private func deleteOldFiles(logsFolder:URL) {
        do {
            if let filePathSorted = try FileManager.default.contentsOfDirectoryByDate(atURL: logsFolder, sortedBy: .created) {
//                print("filePaths: \(filePathSorted)")
                if filePathSorted.count > TextLog.filesMax, let oldest = filePathSorted.first {
                    let olderstFullPath = logsFolder.appendingPathComponent(oldest)
                    do {
                        try FileManager.default.removeItem(at: olderstFullPath)
                        print("🔵 Successfully delete file at path \(olderstFullPath)")
                    } catch {
                        let err = "🚫🔴Unale to delete file \(oldest)"
                        print(err)
                    }
                }
            }
        } catch {
            let err = "🔴 Couldn't get any thind inside folder: \(logsFolder)"
            print(err)
        }
    }
    
    mutating private func getLogFilePath(logsFolder:URL) -> URL {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd_MM_yyyy"
        let fileName = dateFormatter.string(from: Date()).capitalized
        return logsFolder.appendingPathComponent("\(fileName).txt")
    }
    
    mutating private func checkFileExists(fileUrl:URL) {
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
        }
    }
    
    mutating private func checkFolderExists(folderPath:URL) -> Bool {
        var isFolder = ObjCBool(true)
        if !FileManager.default.fileExists(atPath: folderPath.path, isDirectory: &isFolder) {
            do {
                try FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: true, attributes: nil)
                return true
            } catch {
                let err = "🚫 Can't Create folder: \(folderPath)"
                print(err)
                return false
            }
        } else {
            return true
        }
    }
    
}
