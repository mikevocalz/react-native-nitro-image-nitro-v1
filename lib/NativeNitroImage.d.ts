import 'react-native-nitro-modules';
/**
 * The native renderable `<NativeNitroImage />` view.
 * @example
 * ```tsx
 * function App() {
 *   const image = useImage('https://picsum.photos/seed/123/400')
 *   return <NativeNitroImage image={image} style={{ width: 100, height: 100 }} />
 * }
 * ```
 */
export declare const NativeNitroImage: import("react-native").HostComponent<import("react-native").ViewProps & Pick<import("./specs/ImageView.nitro").NitroImageView, "image" | "recyclingKey" | "resizeMode"> & {
    hybridRef?: (view: import("./specs/ImageView.nitro").NitroImageViewRef) => void;
}>;
