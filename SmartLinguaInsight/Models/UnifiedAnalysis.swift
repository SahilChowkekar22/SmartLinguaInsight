//
//  UnifiedAnalysis.swift
//  SmartLinguaInsight
//
//  Created by Sahil ChowKekar on 11/14/25.
//

import Foundation

struct UnifiedAnalysis {
    let originalText: String
    let detectedLanguage: String
    let translatedText: String
    let sentiment: SentimentResult
    let processingTime: TimeInterval
}
