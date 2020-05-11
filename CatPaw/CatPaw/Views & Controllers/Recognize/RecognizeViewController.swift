//
//  RecognizeViewController.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//


import SwiftUI
import Combine

final class RecognizeViewController: UIHostingController<RecognizeView>, ImagePickerDelegate {
    
    private var imagePicker: ImagePicker?
    private var model = MobileNetV2FP16()
    private var recognizeToken: Cancellable?
    
    override init(rootView: RecognizeView) {
        super.init(rootView: rootView)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        configureCommunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCommunication() {
        recognizeToken = rootView.publisher.sink { [weak self] in
            self?.imagePicker?.present(from: UIView())
        }
    }

    private func catCheck(result: String) -> Bool {
        return result.contains(" cat ") || result.contains(" cat") || result.contains("cat ") || result.contains("cat,")
    }
    // MARK: ImagePicker call it, when user select photo
    internal func didSelect(image: UIImage?) {
        if let safeImage = image {
            self.rootView.source.recognizeImage = safeImage
            sceneLabel(forImage: safeImage) { [weak self] labelProbs in
                DispatchQueue.main.async {
                    if let safeResult = labelProbs {
                        var maxRes = ""
                        var max: Double = -1
                        var satisfactory: [String] = []
                        for item in safeResult {
                            if item.value > max {
                                max = item.value
                                maxRes = item.key
                            }
                            if item.value > 0.1 {
                                let resultString = item.key.lowercased()
                                if self?.catCheck(result: resultString) ?? false {
                                    satisfactory.append(item.key)
                                }
                            }
                        }
                        if self?.catCheck(result: maxRes) ?? false {
                            self?.rootView.source.recognizeResult = "Definitely a cat"
                            self?.rootView.source.recognizeResultColor = UIColor.systemGreen
                        } else if satisfactory.count > 0 {
                            self?.rootView.source.recognizeResult = "Probable a cat"
                            self?.rootView.source.recognizeResultColor = UIColor.systemYellow
                        } else {
                            self?.rootView.source.recognizeResult = "Not a cat"
                            self?.rootView.source.recognizeResultColor = UIColor.systemRed
                        }
                    }
                }
            }
        }
    }
    // MARK: Process the photo, for cat identify
    private func sceneLabel(forImage image: UIImage, completion: @escaping (([String:Double]?)->())) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { [weak self] in
            if let safeImage = image.cgImage {
                if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: safeImage) {
                    guard let scene = try? self?.model.prediction(image: pixelBuffer) else {fatalError("Unexpected runtime error")}
                        completion(scene.classLabelProbs)
                }
            }
            completion(nil)
        }
    }
    
}
