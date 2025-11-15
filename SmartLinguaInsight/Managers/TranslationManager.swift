//
//  TranslationManager.swift
//  SmartLinguaInsight
//
//  Created by Sahil ChowKekar on 11/14/25.
//

import Foundation
import NaturalLanguage
import Translation


final class TranslationManager {

    private let dictionary: [String: [String: String]] = [
        "es": [ // Spanish to English
            "hola": "hello",
            "mundo": "world"
        ],
        "fr": [ // French to English
            "bonjour": "hello",
            "monde": "world"
        ],
        "de": [ // German to English
            "hallo": "hello",
            "welt": "world"
        ],
        "hi": [ // Hindi to English
            "नमस्ते": "hello",
            "दुनिया": "world"
        ]
    ]

    func translateToEnglish(text: String, from sourceLang: String) -> String {
        guard let map = dictionary[sourceLang] else {
            return text // fallback
        }

        let words = text.lowercased().split(separator: " ")
        let translated = words.map { map[String($0)] ?? String($0) }
        return translated.joined(separator: " ")
    }
}

