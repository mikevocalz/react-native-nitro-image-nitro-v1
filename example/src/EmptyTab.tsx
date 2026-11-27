import { useMemo, useState } from 'react'
import { StyleSheet, Text, TextInput, View } from 'react-native'
import { Images, NitroImage } from 'react-native-nitro-image'

function parseSize(value: string): number {
  const size = Number.parseInt(value, 10)
  return Number.isFinite(size) && size > 0 ? Math.min(size, 2048) : 1
}

export function EmptyTab() {
  const [value, setValue] = useState('600')
  const size = parseSize(value)
  const image = useMemo(
    () =>
      Images.createBlankImage(size, size, true, {
        r: 0.2,
        g: 0.4,
        b: 0.9,
        a: 1,
      }),
    [size],
  )

  return (
    <View style={styles.container}>
      <TextInput
        placeholder="Image size"
        keyboardType="number-pad"
        value={value}
        onChangeText={setValue}
        style={styles.textInput}
      />
      <Text testID="image-size">
        {image.width} x {image.height}
      </Text>
      <NitroImage image={image} style={styles.image} />
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  textInput: {
    borderWidth: 1,
    borderRadius: 5,
    paddingHorizontal: 10,
    minWidth: 120,
  },
  image: {
    width: 350,
    height: 350,
    backgroundColor: 'grey',
    marginTop: 15,
  },
})
