import 'react-native-nitro-modules'
import { ImageUtils } from './specs/ImageUtils.nitro'

const utils: ImageUtils = new ImageUtils()

/**
 * Returns `true` when the host platform supports loading Images
 * in `HEIC` format.
 */
export const supportsHeicLoading = utils.supportsHeicLoading
/**
 * Returns `true` when the host platform supports writing Images
 * in `HEIC` format.
 */
export const supportsHeicWriting = utils.supportsHeicWriting

export const thumbHashToBase64String = utils.thumbHashToBase64String.bind(utils)

export const thumbHashFromBase64String =
  utils.thumbhashFromBase64String.bind(utils)
