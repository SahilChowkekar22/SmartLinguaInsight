//
//  LanguageDetectionManager.swift
//  SmartLinguaInsight
//
//  Created by Assistant on 11/14/25.
//

import Foundation
import NaturalLanguage

final class LanguageDetectionManager {

    /// Detect the dominant language for a given text.
    /// - Parameter text: The input text to analyze.
    /// - Returns: A language code like "en", "es", etc., or "und" if undetermined.
    @available(iOS 12.0, *)
    func detectLanguage(for text: String) -> String {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return "und" }

        // Create a fresh recognizer per call for thread-safety
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(trimmed)

        // Use dominantLanguage for best-effort detection
        if let lang = recognizer.dominantLanguage {
            // Convert to a language code string (typically ISO 639-1 like "en")
            return lang.rawValue
        } else {
            return "und"
        }
    }
}
