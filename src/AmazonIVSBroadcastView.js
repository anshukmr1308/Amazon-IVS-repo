import React, { useEffect } from 'react';
import { Button, NativeModules, requireNativeComponent } from 'react-native';
import { Dimensions } from 'react-native';
const NativeBroadcastView = requireNativeComponent('AmazonIVSBroadcastView');
// const { AmazonIVSBroadcastViewManager } = NativeModules; 

const AmazonIVSBroadcastView = () => {
    const screenHeight = Dimensions.get('window').height;

    
    // useEffect(() => {
    //     console.log("AmazonIVSBroadcastView mounted");
    // }, []);

    // const createStage = () => {
    //     // Delay the creation to make sure the view is initialized
    //     setTimeout(() => {
    //       AmazonIVSBroadcastViewManager.createStage()
    //         .then(response => {
    //           console.log('Stage created successfully:', response);
    //         })
    //         .catch(error => {
    //           console.error('Error creating stage:', error);
    //         });
    //     }, 200);  // Adjust the delay (200ms is a good start)
    //   };

    return (
        <>
        <NativeBroadcastView 
            style={{ 
                height: screenHeight / 2,  // Half of the screen height
                backgroundColor: 'white' 
            }} 
        />
        {/* <Button title='Create new stage ' onPress={createStage}/> */}
        
        
        </>
        
    );
};

export default AmazonIVSBroadcastView;