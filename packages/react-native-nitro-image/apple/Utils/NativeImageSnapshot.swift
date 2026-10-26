//
//  NativeImageSnapshot.swift
//  react-native-nitro-image
//

import UIKit

/// A `Sendable` `NativeImage` holding only a `UIImage`.
///
/// Nitro V1's `Promise.async` takes a `sending` closure, so the `NativeImage` default
/// `*Async` implementations cannot capture `self` (conformers are not required to be
/// `Sendable`). Every default implementation reads only `uiImage`, so they read it once on
/// the calling thread and run the synchronous variant on this snapshot inside the Promise.
struct NativeImageSnapshot: NativeImage, Sendable {
  let uiImage: UIImage
}
