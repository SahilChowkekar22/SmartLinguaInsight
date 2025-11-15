# SmartLinguaInsight  
### AI-powered Image → Text → Language Detection → Offline Translation → Sentiment Analysis


**SmartLinguaInsight** is an end-to-end multimodal AI text analysis tool built for iOS 17+.  
It extracts text from images, detects the language, translates it (offline), analyzes sentiment,  
and outputs a unified structured report — all using Apple’s on-device ML frameworks.

This project demonstrates modern iOS ML workflows, Vision OCR, Natural Language Processing,  
offline translation logic, and a clean MVVM + Manager Layer architecture.

---

## Features

### **Image Text Extraction (OCR)**
- Powered by **Vision**
- Supports JPG / PNG / HEIC
- Extracts multi-line and multi-font text

### **Automatic Language Detection**
- Uses **NLLanguageRecognizer**
- Supports 50+ languages
- High accuracy for short & long text

### **Offline Translation Engine**
- Fully offline — no network calls  
- Supported mappings:  
  - Spanish → English  
  - French → English  
  - German → English  
  - Hindi → English  
- Word + phrase dictionary matching  
- Handles punctuation & normalization

### **Sentiment Analysis**
- Uses Apple **NaturalLanguage** sentiment scoring  
- Positive / Neutral / Negative  
- Returns confidence score

---

## Project Structure

SmartLinguaInsight
- Managers
  - ImageTextExtractor.swift
  - LanguageDetectionManager.swift
  - PipelineManager.swift
  - SentimentAnalyzer.swift
  - TranslationManager.swift
- Models
  - AppError.swift
  - SentimentResult.swift
  - UnifiedAnalysis.swift
- ViewModels
  - AnalysisViewModel.swift
- Views
  - AnalysisView.swift
- Assets
- ContentView.swift
- SmartLinguaInsightApp.swift

---

## Installation & Setup

###  Clone the Repository
```sh
git clone https://github.com/SahilChowkekar22/SmartLinguaInsight.git
```
```sh
cd SmartLinguaInsight
```
---

###  How It Works (User Flow)
#### 1. Choose a Photo

Select an image from your device using the built-in photo picker.

#### 2. Preview the Image

The selected image appears with a clean, rounded-corner preview.

#### 3. Tap Run Analysis

The app triggers the complete processing pipeline:

```sh
OCR → Language Detection → Offline Translation → Sentiment Analysis → Unified Report
```

#### 4. View Results

A structured, scrollable result card displays:

- Extracted text

- Detected language

- Offline English translation

- Sentiment label + score

- Processing time

