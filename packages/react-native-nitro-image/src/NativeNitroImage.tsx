import 'react-native-nitro-modules'
import { NitroImageViewComponent } from './specs/ImageView.nitro'

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
export const NativeNitroImage = NitroImageViewComponent
