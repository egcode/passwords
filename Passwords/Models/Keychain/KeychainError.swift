//
//  KeychainError.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import Foundation

public enum KeychainError: Error {
    case string2DataConversionError
    case data2StringConversionError
    case unhandledError(message: String)
}

extension KeychainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .string2DataConversionError:
            return NSLocalizedString("String to Data conversion error", comment: "Error dialog message")
        case .data2StringConversionError:
            return NSLocalizedString("Data to String conversion error", comment: "Error dialog message")
        case .unhandledError(let message):
            return NSLocalizedString(message, comment: "Error dialog message")
        }
    }
}
