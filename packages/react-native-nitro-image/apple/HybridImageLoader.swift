//
//  HybridImageLoader.swift
//  NitroImage
//
//  Created by Marc Rousavy on 25.07.25.
//

import Foundation
import NitroModules
import UIKit

// `@unchecked Sendable`: V1 Promise listeners are `@Sendable`. The only mutable
// state, `cachedResult`, is guarded by `lock`.
final class HybridImageLoader: HybridImageLoaderSpec, @unchecked Sendable {
  typealias LoadFunc = () throws -> any Promise<any HybridImageSpec>

  private let load: LoadFunc
  private let allowCaching: Bool
  private let lock = NSLock()
  private var cachedResult: (any HybridImageSpec)? = nil

  init(load: @escaping LoadFunc, allowCaching: Bool = true) throws {
    self.load = load
    self.allowCaching = allowCaching
    try super.init()
  }

  func dispose() {
    lock.withLock { self.cachedResult = nil }
  }

  func loadImage() throws -> any Promise<any HybridImageSpec> {
    if allowCaching {
      // We can cache the last loaded image in state, so future requests receive it instantly
      if let cachedResult = lock.withLock({ self.cachedResult }) {
        return .resolved(with: cachedResult)
      }
      let promise = try load()
      promise.addOnResolvedListener { [weak self] image in
        guard let self else { return }
        nonisolated(unsafe) let image = image
        self.lock.withLock { self.cachedResult = image }
      }
      return promise
    } else {
      // We need to reload the Image each time.
      return try load()
    }
  }

  func requestImage(forView view: any HybridNitroImageViewSpec) throws {
    guard let view = view as? NativeImageView else { return }
    nonisolated(unsafe) let imageView = view
    try loadImage().addOnResolvedListener { image in
      guard let image = image as? NativeImage else { return }
      nonisolated(unsafe) let uiImage = image.uiImage
      DispatchQueue.runOnMain {
        imageView.imageView.image = uiImage
      }
    }
  }

  func dropImage(forView view: any HybridNitroImageViewSpec) throws {
    guard let view = view as? NativeImageView else { return }
    nonisolated(unsafe) let imageView = view
    DispatchQueue.runOnMain {
      imageView.imageView.image = nil
    }
  }
}
