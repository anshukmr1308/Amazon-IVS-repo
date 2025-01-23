import { NativeEventEmitter, NativeModules } from 'react-native';

const { BroadcastEventEmitter } = NativeModules;
export default new NativeEventEmitter(BroadcastEventEmitter);