/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React, { useEffect, useState } from 'react';
import {
  Alert,
  Button,
  requireNativeComponent,
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
} from 'react-native';

import {
  Colors,
  Header,
} from 'react-native/Libraries/NewAppScreen';
// import checkPermissions from './src/checkPermission';
import { createStage } from './src/IVSManager';
// import BroadcastingView from './src/broadcastingView';
import AmazonIVSBroadcastView from './src/AmazonIVSBroadcastView';

// const SwiftView = requireNativeComponent('MultihostViewController');

const App = () => {
  const isDarkMode = useColorScheme() === 'dark';
  const [broadcastData, setBroadcastData] = useState(null);

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  // useEffect(() => {
  //   checkPermissions()
  // }, [])
  const handleCreateStage = async () => {
    try {
      const response = await createStage('user123', 'John Doe', 'https://d39ii5l128t5ul.cloudfront.net/assets/animals_square/bear.png');
      setBroadcastData(response)

      Alert.alert('Success', `Stage Created: ${JSON.stringify(response)}`);
    } catch (error) {
      Alert.alert('Error', error);
    }
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <View >
      {/* <SwiftView style={styles.nativeView} /> */}
        {/* {broadcastData && ( */}
          <AmazonIVSBroadcastView />
        {/* )} */}
        {/* <Button title='Create new stage' onPress={handleCreateStage} /> */}
        {/* )} */}

      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
  nativeView: {
    width: 200,
    height: 100,
    backgroundColor: 'pink'
  },
});

export default App;
