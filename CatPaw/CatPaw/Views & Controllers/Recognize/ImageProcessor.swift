//
//  File.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 10.05.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import CoreVideo

struct ImageProcessor {
    // MARK: Converting a photo to CoreML format
    static func pixelBuffer (forImage image:CGImage) -> CVPixelBuffer? {
        let modelSizeParam = 224
        let frameSize = CGSize(width: modelSizeParam, height: modelSizeParam)
        var pixelBuffer:CVPixelBuffer? = nil
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), kCVPixelFormatType_32BGRA , nil, &pixelBuffer)
        if status != kCVReturnSuccess {
            return nil
        }
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init(rawValue: 0))
        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image, in: CGRect(x: 0, y: 0, width: modelSizeParam, height: modelSizeParam))
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        return pixelBuffer
    }
    
}
