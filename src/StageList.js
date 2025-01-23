import React from 'react';
import { View, Text, FlatList, TouchableOpacity, StyleSheet } from 'react-native';

const StagesList = ({ stages, handleStageClick }) => {
    console.log('Stages data:', stages);
    
    const renderItem = ({ item }) => {
        // Safely access nested properties
        const username = item?.stageAttributes?.username || 'Unknown';
        
        return (
            <TouchableOpacity 
                onPress={() => handleStageClick(item)} 
                style={styles.itemContainer}
            >
                <View style={styles.itemContent}>
                    <Text style={styles.username}>{username}'s Stage</Text>
                </View>
                <View style={styles.separator} />
            </TouchableOpacity>
        );
    };

    return (
        <View style={styles.containerFixed}>
            <FlatList
                data={stages}
                renderItem={renderItem}
                keyExtractor={(item) => item.stageId}
                contentContainerStyle={styles.listContainer}
            />
        </View>
    );
};

const styles = StyleSheet.create({
    containerFixed: {
        height: 200, // Fixed container height
        backgroundColor: '#f5f5f5',
        borderRadius: 8,
        marginVertical: 10,
    },
    listContainer: {
        paddingHorizontal: 16,
        paddingVertical: 8,
    },
    itemContainer: {
        backgroundColor: '#fff',
        borderRadius: 8,
        marginBottom: 8,
        shadowColor: '#000',
        shadowOffset: {
            width: 0,
            height: 2,
        },
        shadowOpacity: 0.1,
        shadowRadius: 4,
        elevation: 3,
    },
    itemContent: {
        padding: 12,
    },
    username: {
        fontSize: 16,
        fontWeight: 'bold',
    },
    separator: {
        height: 1,
        backgroundColor: '#E0E0E0',
    },
});

export default StagesList;