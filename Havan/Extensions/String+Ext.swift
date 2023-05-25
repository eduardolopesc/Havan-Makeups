//
//  String+Ext.swift
//  Havan
//
//  Created by Eduardo on 24/05/23.
//

import Foundation

extension String {
    func removeExtraSpaces() -> String {
        var result = ""
        var previousCharacter: Character?

        for character in self {
            if character.isLetter {
                result.append(character)
            } else if let previousChar = previousCharacter, !previousChar.isWhitespace, !character.isNewline {
                result.append(character)
            }

            previousCharacter = character
        }

        return result
    }
    
    func removeHTMLTags() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributedString.string
        }
        
        return nil
    }
}
