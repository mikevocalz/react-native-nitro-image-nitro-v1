//
//  HybridImageFactory.swift
//  react-native-nitro-image
//
//  Created by Marc Rousavy on 10.06.25.
//

import Foundation
import UIKit
import NitroModules

// `@unchecked Sendable`: the factory has no stored state. The async variants
// capture `self` in V1's `sending` Promise.async closures.
final class HybridImageFactory: HybridImageFactorySpec, @unchecked Sendable {
  /**
   * Create new blank Image
   */
  func createBlankImage(width: Double, height: Double, enableAlpha: Bool, fill: Color?) throws -> any HybridImageSpec {
    // 1. Prepare image config
    let size = CGSize(width: width, height: height)
    let format = UIGraphicsImageRendererFormat()
    format.opaque = !enableAlpha
    format.scale = 1
    // 2. Create a new UIImage
    let uiImage = UIGraphicsImageRenderer(size: size, format: format).image { canvas in
      if let fill {
        // 3. If we have a fill, fill the screen with that color
        let color = fill.toUIColor()
        color.setFill()
        let wholeArea = CGRect(origin: .zero, size: size)
        canvas.fill(wholeArea)
      }
    }
    // 4. Wrap it in HybridImage
    return try HybridImage(uiImage: uiImage)
  }

  func createBlankImageAsync(width: Double, height: Double, enableAlpha: Bool, fill: Color?) throws -> any Promise<any HybridImageSpec> {
    return .async {
      return try self.createBlankImage(width: width, height: height, enableAlpha: enableAlpha, fill: fill)
    }
  }

  /**
   * Load Image from file path
   */
  func loadFromFile(filePath rawFilePath: String) throws -> any HybridImageSpec {
    let filePath = rawFilePath.normalizedFilePath
    guard let uiImage = UIImage(contentsOfFile: filePath) else {
      throw RuntimeError("Failed to read image from file \"\(filePath)\"!")
    }
    return try HybridImage(uiImage: uiImage)
  }
  func loadFromFileAsync(filePath: String) throws -> any Promise<any HybridImageSpec> {
    return .async {
      return try self.loadFromFile(filePath: filePath)
    }
  }

  /**
   * Load Image from resources
   */
  func loadFromResources(name: String) throws -> any HybridImageSpec {
    guard let uiImage = UIImage(named: name) else {
      throw RuntimeError("Image \"\(name)\" cannot be found in main resource bundle!")
    }
    return try HybridImage(uiImage: uiImage)
  }
  func loadFromResourcesAsync(name: String) throws -> any Promise<any HybridImageSpec> {
    return .async {
      return try self.loadFromResources(name: name)
    }
  }

  /**
   * Load Image from SF Symbol Name
   */
  func loadFromSymbol(symbolName: String) throws -> any HybridImageSpec {
    guard let uiImage = UIImage(systemName: symbolName) else {
      throw RuntimeError("No Image with the symbol name \"\(symbolName)\" found!")
    }
    return try HybridImage(uiImage: uiImage)
  }

  /**
   * Load Image from the given raw ArrayBuffer data
   */
  func loadFromRawPixelData(data: RawPixelData, allowGpu _ : Bool?) throws -> any HybridImageSpec {
    let uiImage = try UIImage(fromRawPixelData: data)
    return try HybridImage(uiImage: uiImage)
  }

  func loadFromRawPixelDataAsync(data: RawPixelData, allowGpu: Bool?) throws -> any Promise<any HybridImageSpec> {
    let maybeBufferCopy = data.buffer.asOwning()
    let newData = OwnedRawPixelData(value: RawPixelData(buffer: maybeBufferCopy,
                                                        width: data.width,
                                                        height: data.height,
                                                        pixelFormat: data.pixelFormat))
    return .async {
      return try self.loadFromRawPixelData(data: newData.value, allowGpu: allowGpu)
    }
  }

  /**
   * Load Image from the given encoded ArrayBuffer data
   */
  func loadFromEncodedImageData(data: EncodedImageData) throws -> any HybridImageSpec {
    let copiedData = data.buffer.toData(copyIfNeeded: false)
    guard let uiImage = UIImage(data: copiedData) else {
      throw RuntimeError("The given ArrayBuffer could not be converted to a UIImage!")
    }
    return try HybridImage(uiImage: uiImage)
  }

  func loadFromEncodedImageDataAsync(data: EncodedImageData) throws -> any Promise<any HybridImageSpec> {
    let copiedData = data.buffer.toData(copyIfNeeded: true)
    return .async {
      guard let uiImage = UIImage(data: copiedData) else {
        throw RuntimeError("The given ArrayBuffer could not be converted to a UIImage!")
      }
      return try HybridImage(uiImage: uiImage)
    }
  }


  func loadFromThumbHash(thumbhash: ArrayBuffer) throws -> any HybridImageSpec {
    let data = thumbhash.toData(copyIfNeeded: false)
    let uiImage = thumbHashToImage(hash: data)
    return try HybridImage(uiImage: uiImage)
  }
  func loadFromThumbHashAsync(thumbhash: ArrayBuffer) throws -> any Promise<any HybridImageSpec> {
    let data = thumbhash.toData(copyIfNeeded: true)
    return .async {
      let uiImage = thumbHashToImage(hash: data)
      return try HybridImage(uiImage: uiImage)
    }
  }
}
