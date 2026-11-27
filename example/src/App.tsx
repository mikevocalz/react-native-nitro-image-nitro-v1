/**
 * NitroImage example app.
 *
 * react-native-nitro-web-image is not ported to Nitro V1 yet, so the tabs only
 * use images created in memory.
 */

import { useState } from 'react'
import { Pressable, SafeAreaView, StyleSheet, Text, View } from 'react-native'
import { EmptyTab } from './EmptyTab'
import { NitroImageTab } from './NitroImageTab'

const TABS = {
  Empty: EmptyTab,
  NitroImage: NitroImageTab,
} as const
type TabName = keyof typeof TABS

function App(): React.JSX.Element {
  const [tab, setTab] = useState<TabName>('Empty')
  const Screen = TABS[tab]

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.screen}>
        <Screen />
      </View>
      <View style={styles.tabBar}>
        {(Object.keys(TABS) as TabName[]).map((name) => (
          <Pressable
            key={name}
            testID={`tab-${name}`}
            onPress={() => setTab(name)}
            style={styles.tab}
          >
            <Text style={name === tab ? styles.activeLabel : styles.label}>
              {name}
            </Text>
          </Pressable>
        ))}
      </View>
    </SafeAreaView>
  )
}

const styles = StyleSheet.create({
  container: { flex: 1 },
  screen: { flex: 1 },
  tabBar: {
    flexDirection: 'row',
    borderTopWidth: StyleSheet.hairlineWidth,
    borderTopColor: 'grey',
  },
  tab: { flex: 1, alignItems: 'center', paddingVertical: 12 },
  label: { color: 'grey' },
  activeLabel: { fontWeight: '600' },
})

export default App
