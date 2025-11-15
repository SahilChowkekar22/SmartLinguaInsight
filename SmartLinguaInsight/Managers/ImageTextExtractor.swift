//
//  ImageTextExtractor.swift
//  SmartLinguaInsight
//
//  Created by Sahil ChowKekar on 11/14/25.
//

import Foundation
import Vision
import UIKit

final class ImageTextExtractor {

    func extractText(from image: UIImage) async throws -> String {
        guard let cgImage = image.cgImage else {
            throw AppError.unsupportedImageFormat
        }

        let request = VNRecognizeTextRequest()
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

        try handler.perform([request])

        let results = request.results ?? []
        let text = results.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")

        if text.isEmpty { throw AppError.noTextFound }
        return text
    }
}
