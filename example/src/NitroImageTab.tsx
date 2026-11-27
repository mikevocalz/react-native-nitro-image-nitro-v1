import { useMemo } from 'react'
import { FlatList, StyleSheet, Text, View } from 'react-native'
import { Images, NitroImage } from 'react-native-nitro-image'
import { createImageColors } from './createImageColors'

export function NitroImageTab() {
  const images = useMemo(
    () =>
      createImageColors().map((color, index) => ({
        key: `image-${index}`,
        image: Images.createBlankImage(200, 200, true, color),
      })),
    [],
  )

  return (
    <View style={styles.container}>
      <Text>NitroImage Tab</Text>
      <FlatList
        numColumns={4}
        windowSize={3}
        data={images}
        keyExtractor={(item) => item.key}
        renderItem={({ item }) => (
          <NitroImage
            image={item.image}
            recyclingKey={item.key}
            style={styles.image}
            resizeMode="cover"
          />
        )}
      />
    </View>
  )
}

const styles = StyleSheet.create({
  container: { flex: 1 },
  image: {
    width: '25%',
    aspectRatio: 1,
  },
})
