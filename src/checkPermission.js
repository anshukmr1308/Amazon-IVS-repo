import { NativeModules } from 'react-native';

const { PermissionsManager } = NativeModules;

async function checkPermissions() {
    try {
        const granted = await PermissionsManager.checkAVPermissions();
        console.log(granted,'==================');
        if (granted) {
           
            
            // console.log('Permissions granted for both camera and audio.');
        } else {
            console.log('Permissions denied.');
        }
    } catch (error) {
        console.error('Error checking permissions:', error);
    }
}

// Call the function
export default checkPermissions;
