import { NativeModules } from 'react-native';

const { ServerManager } = NativeModules;

// Create Stage
export const createStage = async (userId, username, avatarUrl) => {
  try {
    const response = await ServerManager.createStage(userId, username, avatarUrl);
    // console.log('Stage created successfully:', response);
    return response;
  } catch (error) {
    console.error('Failed to create stage:', error);
    throw error;
  }
};

// List Stages
export const listStages = async () => {
  try {
    console.log('Starting getAllStages request...');
    const response = await ServerManager.getAllStages();
    console.log('Raw response from getAllStages:', response);
    
    // Validate response structure
    if (!response) {
      throw new Error('No response received from server');
    }
    
    return response;
  } catch (error) {
    console.error('Detailed error in listStages:', {
      message: error.message,
      code: error.code,
      domain: error.domain,
      name: error.name,
      stack: error.stack
    });
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
