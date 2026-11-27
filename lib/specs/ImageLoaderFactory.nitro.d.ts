import { type HybridObject } from 'react-native-nitro-modules';
import type { EncodedImageData, RawPixelData } from './Image.nitro';
import type { ImageLoader } from './ImageLoader.nitro';
export declare class ImageLoaderFactory extends HybridObject {
    constructor();
    /**
     * Creates an {@linkcode ImageLoader} from a filesystem path such as `/tmp/image.jpg`, not a `file://` URL.
     */
    createFileImageLoader(filePath: string): ImageLoader;
    createResourceImageLoader(name: string): ImageLoader;
    createSymbolImageLoader(symbolName: string): ImageLoader;
    createRawPixelDataImageLoader(data: RawPixelData): ImageLoader;
    createEncodedImageDataImageLoader(data: EncodedImageData): ImageLoader;
}
export * from '#nitro/ImageLoaderFactory';
