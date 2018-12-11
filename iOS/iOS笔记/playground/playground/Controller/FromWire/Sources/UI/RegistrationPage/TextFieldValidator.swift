//
//  TextFieldValidator.swift
//  playground
//
//  Created by tree on 2018/11/22.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

class TextFieldValidator {
    var customValidator: ((String) -> ValidationError?)?

    enum ValidationError: Error, Equatable {
        case none
        case invalidEmail
        case tooLong(kind: TextFieldValidator.Kind)
        case tooShort(kind: TextFieldValidator.Kind)
        case custom(String)
    }

    enum Kind: Equatable {
        case email
        case password
        case name
        case unkown
    }

    func validate(text: String?, kind: TextFieldValidator.Kind) -> TextFieldValidator.ValidationError {
        guard let text = text else { return .none }
        switch kind {
        case .email:
            if text.count > 254 {
                return .tooLong(kind: kind)
            }else if !text.isEmail {
                return .invalidEmail
            }
        case .name:
            let stringToValidate = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if stringToValidate.count > 64 {
                return .tooLong(kind: kind)
            }else if stringToValidate.count < 2 {
                return .tooShort(kind: kind)
            }
            break
        case .password:
            if text.count > maxPasswordLength {
                return .tooLong(kind: kind)
            }else if text.count < minPasswordLength {
                return .tooShort(kind: kind)
            }
        case .unkown:
            break
        }
        return .none
    }
}

extension TextFieldValidator {
    var minPasswordLength: Int { return 8 }
    var maxPasswordLength: Int { return 120 }

    // 新属性，用来描述密码的规则
    @available(iOS 12.0, *)
    var passwordRules: UITextInputPasswordRules {
        return UITextInputPasswordRules.init(descriptor: "minlength: \(minPasswordLength); maxlength: \(maxPasswordLength)")
    }
}

extension String {
    /// 代替正则表达式的一种方案，在某些国际化的前提下，正则表达式就不太适用了
    public var isEmail: Bool {
        guard !self.hasPrefix("mailto:") else { return false }

        guard let dataDetector = try? NSDataDetector.init(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }

        let stringToMatch = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let range = NSRange.init(location: 0, length: stringToMatch.count)
        let firstMatch = dataDetector.firstMatch(in: stringToMatch, options: .reportCompletion, range: range)

        let numberOfMatches = dataDetector.numberOfMatches(in: stringToMatch, options: .reportCompletion, range: range)

        if firstMatch?.range.location == NSNotFound { return false }
        if firstMatch?.url?.scheme != "mailto" { return false }
        if firstMatch?.url?.absoluteString.hasSuffix(stringToMatch) == false { return false }
        if numberOfMatches != 1 { return false }

        if self.contains("..") { return false }

        return true
    }
}
