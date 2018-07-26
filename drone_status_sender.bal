import ballerina/mb;
import ballerina/log;

function main (string... args) {
    endpoint mb:SimpleQueueSender droneStatusSender {
      host: "localhost",
        port: 5672,
        queueName: "DroneStatusUpdates"
    };

    json status = {
        drone_id: "DRONE1",
        latitude: 40.156,
        longitude: 72.1345,
        altitude: 100.0,
        battery_remaining: 86.5
    };

    string statusMsg = status.toString();
    mb:Message message = check droneStatusSender.createTextMessage(statusMsg);
    _ = droneStatusSender->send(message);    
}


