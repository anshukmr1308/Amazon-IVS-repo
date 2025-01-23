import React, { useEffect, useState } from 'react';
import { Button, NativeModules, requireNativeComponent } from 'react-native';
import { Dimensions } from 'react-native';
import BroadcastEventEmitter from './BroadcastEventEmitter';
import { listStages } from './IVSManager';
import StagesList from './StageList';
import ChatInput from './ChatInput';

const NativeBroadcastView = requireNativeComponent('AmazonIVSBroadcastView');
const { AmazonIVSBroadcastViewManager } = NativeModules;

const AmazonIVSBroadcastView = () => {

  const [isPresent, setIsPresent] = useState(false);
  const [stages, setStages] = useState([]);
  const [joinSteamBtnUser, setJoinSteamBtnUser] = useState(false);

  const screenHeight = isPresent ? 0 : Dimensions.get('window').height;
  const fetchStages = async () => {
    try {
      console.log('Fetching stages...');
      const response = await listStages();
      // console.log('Received stages response:', response.stages);
      setStages(response.stages);
    } catch (err) {
      console.error('Error in component:', err);
      // setError(err.message);
    }
  };


  useEffect(() => {
    fetchStages();

    const appearSubscription = BroadcastEventEmitter.addListener(
      'onBroadcastAppear',
      (event) => {
        setIsPresent(event.isPresent);
        console.log('Broadcast presence changed:', event.isPresent);
      }
    );

    // New subscription for preview page state
    const previewPageSubscription = BroadcastEventEmitter.addListener(
      'onPreviewPageState',
      (event) => {
        setJoinSteamBtnUser(event.isPreviewPage);
        console.log('Preview page state changed:', event.isPreviewPage);
      }
    );

    return () => {
      appearSubscription.remove();
      previewPageSubscription.remove();
    };
  }, []);


  const handleCreateStage = () => {

    setTimeout(() => {
      AmazonIVSBroadcastViewManager.createStageFromReact();
    }, 1000);

  };

  const handleStageClick = (stage) => {
    // Create stage details object matching the Swift side requirements
    const stageDetails = {
      roomId: stage.roomId,
      channelId: stage.channelId,
      stageAttributes: {
        username: stage.stageAttributes.username,
        avatarUrl: stage.stageAttributes.avatarUrl
      },
      groupId: stage.groupId,
      stageId: stage.stageId
    };

    console.log('Sending stage details to native:', stageDetails);
    AmazonIVSBroadcastViewManager.onClickStageFromReact(stageDetails);
  };

  const handleCancel = () => {
    AmazonIVSBroadcastViewManager.handleCancelFromReact();

  };

  const handleJoin = () => {
    AmazonIVSBroadcastViewManager.handleJoinFromReact();
  };



  return (
    <>
      <NativeBroadcastView
        style={{
          height: screenHeight / 2,
          backgroundColor: 'white'
        }}
      />
      {isPresent && <StagesList
        stages={stages}
        handleStageClick={handleStageClick}
      />}
      {isPresent && <Button title='Create new stage ' onPress={handleCreateStage} />}
      {joinSteamBtnUser && (
        <>
          <Button title='Cancel button' onPress={handleCancel} />
          <Button title='Join' onPress={handleJoin} />
        </>
      )}

      <ChatInput />
    </>

  );
};

export default AmazonIVSBroadcastView;