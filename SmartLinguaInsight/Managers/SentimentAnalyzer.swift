//
//  SentimentAnalyzer.swift
//  SmartLinguaInsight
//
//  Created by Sahil ChowKekar on 11/14/25.
//

import Foundation
import NaturalLanguage

final class SentimentAnalyzer {

    func analyze(_ text: String) throws -> SentimentResult {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        let (tag, _) = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore)
        let raw = tag?.rawValue ?? "0"
        let numericScore = Double(raw) ?? 0

        let label: String
        if numericScore > 0.1 {
            label = "positive"
        } else if numericScore < -0.1 {
            label = "negative"
        } else {
            label = "neutral"
        }

        return SentimentResult(label: label, score: numericScore)
    }
}
