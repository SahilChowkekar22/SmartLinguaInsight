//
//  AnalysisView.swift
//  SmartLinguaInsight
//
//  Created by Sahil ChowKekar on 11/14/25.
//

import Foundation
import SwiftUI
import PhotosUI

@available(iOS 17.0, *)
struct AnalysisView: View {

    @StateObject private var vm = AnalysisViewModel()
    @State private var selectedImage: UIImage?
    @State private var pickerItem: PhotosPickerItem?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    // MARK: - Image Preview
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 240)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 6)
                            .padding(.horizontal)
                    } else {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 240)
                            .overlay(
                                Text("No Image Selected")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            )
                            .padding(.horizontal)
                    }

                    // MARK: - PICK IMAGE BUTTON
                    PhotosPicker(
                        selection: $pickerItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Label("Choose Photo", systemImage: "photo")
                            .font(.system(size: 18, weight: .semibold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.15))
                            .foregroundStyle(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                    }
                    .onChange(of: pickerItem) { newItem in
                        loadImage(from: newItem)
                    }

                    // MARK: - RUN ANALYSIS BUTTON
                    Button(action: {
                        if let img = selectedImage {
                            vm.analyze(image: img)
                        }
                    }) {
                        Label("Run Analysis", systemImage: "bolt.fill")
                            .font(.system(size: 18, weight: .bold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedImage == nil ? Color.gray.opacity(0.2) : Color.blue)
                            .foregroundColor(selectedImage == nil ? .gray : .white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(vm.isLoading || selectedImage == nil)
                    .padding(.horizontal)
                    .padding(.bottom, 8)

                    if vm.isLoading {
                        ProgressView("Analyzing…")
                            .padding()
                    }

                    // MARK: - RESULTS
                    if let result = vm.analysis {
                        resultCard(result)
                            .padding(.horizontal)
                    }

                    // MARK: - ERROR MESSAGE
                    if let error = vm.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding(.top, 4)
                    }

                    Spacer(minLength: 40)
                }
            }
            .navigationTitle("SmartLingua Insight")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - RENDER RESULT CARD
    @ViewBuilder
    private func resultCard(_ result: UnifiedAnalysis) -> some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Analysis Result")
                .font(.title3.bold())

            Divider()

            Group {
                labeledText("Original Text", result.originalText)
                labeledText("Detected Language", result.detectedLanguage.uppercased())
                labeledText("Translated Text", result.translatedText)
                labeledText("Sentiment", result.sentiment.label.capitalized)
                labeledText("Processing Time", "\(String(format: "%.2f", result.processingTime)) sec")
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(radius: 3)
    }

    // MARK: - Helper UI Label
    private func labeledText(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
            Text(value)
                .font(.body.weight(.medium))
        }
    }

    // MARK: - Load image from PhotosPickerItem
    private func loadImage(from item: PhotosPickerItem?) {
        Task {
            guard let item else { return }

            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                selectedImage = uiImage
                vm.analysis = nil      // clear old results
                vm.errorMessage = nil  // clear old errors
            }
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        AnalysisView()
    } else {
        Text("iOS 17+ Required")
    }
}
