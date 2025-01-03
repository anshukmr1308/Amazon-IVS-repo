import { NativeModules } from 'react-native';

const { ServerManager } = NativeModules;

// Create Stage
export const createStage = async (userId, username, avatarUrl) => {
  try {
    const response = await ServerManager.createStage(userId, username, avatarUrl);
    console.log('Stage created successfully:', response);
    return response;
  } catch (error) {
    console.error('Failed to create stage:', error);
    throw error;
  }
};

// List Stages
export const listStages = async () => {
  try {
    const response = await ServerManager.listStages();
    console.log('Stages listed successfully:', response);
    return response;
  } catch (error) {
    console.error('Failed to list stages:', error);
    throw error;
  }
};

// Join Stage
export const joinStage = async (userId, groupId, username, avatarUrl) => {
  try {
    const response = await ServerManager.joinStage(userId, groupId, username, avatarUrl);
    console.log('Joined stage successfully:', response);
    return response;
  } catch (error) {
    console.error('Failed to join stage:', error);
    throw error;
  }
};

// Delete Stage
export const deleteStage = async (groupId) => {
  try {
    const response = await ServerManager.deleteStage(groupId);
    console.log('Stage deleted successfully:', response);
    return response;
  } catch (error) {
    console.error('Failed to delete stage:', error);
    throw error;
  }
};

// Disconnect Participant
export const disconnectParticipant = async (groupId, participantId, userId) => {
  try {
    const response = await ServerManager.disconnectParticipant(groupId, participantId, userId);
    console.log('Participant disconnected successfully:', response);
    return response;
  } catch (error) {
    console.error('Failed to disconnect participant:', error);
    throw error;
  }
};
