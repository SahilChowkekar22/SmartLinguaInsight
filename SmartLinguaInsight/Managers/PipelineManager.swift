//
//  PipelineManager.swift
//  SmartLinguaInsight
//
//  Created by Sahil ChowKekar on 11/14/25.
//

import Foundation
import UIKit

@available(iOS 17.0, *)
final class PipelineManager {

    private let extractor = ImageTextExtractor()
    private let langDetector = LanguageDetectionManager()
    private let translator = TranslationManager()
    private let sentiment = SentimentAnalyzer()

    func runFullPipeline(on image: UIImage) async throws -> UnifiedAnalysis {

        let start = Date()

        // 1. Extract text
        let extracted = try await extractor.extractText(from: image)

        // 2. Detect language
        let lang = langDetector.detectLanguage(for: extracted)

        if lang == "und" {
            throw AppError.languageDetectionFailed
        }

        // 3. Translate → English
        let translated: String
        do {
            translated = try await translator.translateToEnglish(text: extracted, from: lang)
        } catch {
            translated = extracted  // fallback
        }

        // 4. Sentiment Analysis
        let sentimentResult = try sentiment.analyze(translated)

        // 5. Create Unified Report
        let totalTime = Date().timeIntervalSince(start)

        return UnifiedAnalysis(
            originalText: extracted,
            detectedLanguage: lang,
            translatedText: translated,
            sentiment: sentimentResult,
            processingTime: totalTime
        )
    }
}

