import type { Images } from 'react-native-nitro-image'

type Color = NonNullable<Parameters<typeof Images.createBlankImage>[3]>

const DEFAULT_COUNT = 400

/** One distinct color per grid cell, spread around the hue circle. */
export function createImageColors(count: number = DEFAULT_COUNT): Color[] {
  return [...Array(count).keys()].map((index) => {
    const hue = (index * 37) % 360
    const x = 1 - Math.abs(((hue / 60) % 2) - 1)
    const [r, g, b] =
      hue < 60
        ? [1, x, 0]
        : hue < 120
          ? [x, 1, 0]
          : hue < 180
            ? [0, 1, x]
            : hue < 240
              ? [0, x, 1]
              : hue < 300
                ? [x, 0, 1]
                : [1, 0, x]
    return { r, g, b, a: 1 }
  })
}
