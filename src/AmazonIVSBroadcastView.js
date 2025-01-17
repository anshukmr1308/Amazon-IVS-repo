import React, { useEffect } from 'react';
import { Button, NativeModules, requireNativeComponent } from 'react-native';
import { Dimensions } from 'react-native';

const NativeBroadcastView = requireNativeComponent('AmazonIVSBroadcastView');
const { AmazonIVSBroadcastViewManager } = NativeModules;

const AmazonIVSBroadcastView = () => {
    const screenHeight = Dimensions.get('window').height;
    const handleCreateStage = () => {

      setTimeout(() => {
        AmazonIVSBroadcastViewManager.createStageFromReact();
      }, 1000);

      };

    return (
        <>
        <NativeBroadcastView 
            style={{ 
                height: screenHeight / 2, 
                backgroundColor: 'white' 
            }} 
        />
        <Button title='Create new stage ' onPress={handleCreateStage}/> 
        </>

    );
};

export default AmazonIVSBroadcastView;