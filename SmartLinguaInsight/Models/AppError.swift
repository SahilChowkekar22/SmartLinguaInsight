//
//  AppError.swift
//  SmartLinguaInsight
//
//  Created by Sahil ChowKekar on 11/14/25.
//

import Foundation

enum AppError: Error, LocalizedError {
    case imageFailed
    case noTextFound
    case languageDetectionFailed
    case translationFailed
    case sentimentFailed
    case unsupportedImageFormat
    case pipelineFailed

    var errorDescription: String? {
        switch self {
        case .imageFailed: return "Failed to extract text from image."
        case .noTextFound: return "No readable text found."
        case .languageDetectionFailed: return "Unable to detect language."
        case .translationFailed: return "Translation unavailable."
        case .sentimentFailed: return "Sentiment analysis failed."
        case .unsupportedImageFormat: return "Unsupported image format."
        case .pipelineFailed: return "Pipeline execution failed."
        }
    }
}
