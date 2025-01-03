import React, { useRef, useEffect } from 'react';
import { requireNativeComponent, UIManager, findNodeHandle } from 'react-native';

const NativeBroadcastView = requireNativeComponent('AmazonIVSBroadcastView');

const AmazonIVSBroadcastView = ({ ingestEndpoint, streamKey }) => {
    const ref = useRef(null);

    useEffect(() => {
        return () => {
            if (ref.current) {
                UIManager.dispatchViewManagerCommand(
                    findNodeHandle(ref.current),
                    UIManager.AmazonIVSBroadcastView.Commands.stopBroadcast,
                    []
                );
            }
        };
    }, []);

    return (
        <NativeBroadcastView
            ref={ref}
            style={{ flex: 1 }}
            ingestEndpoint={ingestEndpoint}
            streamKey={streamKey}
        />
    );
};

export default AmazonIVSBroadcastView;
