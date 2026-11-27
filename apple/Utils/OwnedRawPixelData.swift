//
//  OwnedRawPixelData.swift
//  react-native-nitro-image
//

import NitroModules

/// Moves a `RawPixelData` into a V1 `Promise.async` closure, which takes a `sending` closure.
/// `RawPixelData` holds an `ArrayBuffer`, which is not `Sendable`.
///
/// `@unchecked Sendable`: callers wrap a value whose buffer they just copied with `asOwning()`,
/// so nothing outside the closure references that buffer.
struct OwnedRawPixelData: @unchecked Sendable {
  let value: RawPixelData
}
