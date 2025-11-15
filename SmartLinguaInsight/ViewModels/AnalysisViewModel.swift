//
//  AnalysisViewModel.swift
//  SmartLinguaInsight
//
//  Created by Sahil ChowKekar on 11/14/25.
//

import Foundation
import Combine
import UIKit


@MainActor
@available(iOS 17.0, *)
final class AnalysisViewModel: ObservableObject {

    @Published var analysis: UnifiedAnalysis?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let pipeline = PipelineManager()

    func analyze(image: UIImage) {
        Task {
            do {
                isLoading = true
                let result = try await pipeline.runFullPipeline(on: image)
                self.analysis = result
                self.errorMessage = nil
            } catch {
                self.errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
