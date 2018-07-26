import ballerina/mb;
import ballerina/log;
import ballerina/grpc;
import ballerina/internal;

public type DroneStatus record {
    string drone_id;
    float latitude;
    float longitude;
    float altitude;
    float battery_remaining;
    !...
};

map<DroneStatus> statusUpdates;

documentation { Queue receiver endpoint for drone location updates }
endpoint mb:SimpleQueueReceiver queueReceiverDroneLocations {
    host: "localhost",
    port: 5672,
    queueName: "DroneStatusUpdates"
};

endpoint grpc:Listener statusListener {
    host: "localhost",
    port: 9091
};

service<mb:Consumer> locationListener bind queueReceiverDroneLocations {
    onMessage(endpoint consumer, mb:Message message) {
        string textStatus = check message.getTextMessageContent();
        json status = check internal:parseJson(textStatus);
        log:printInfo("[Drone Update] " + status.toString());
        DroneStatus|error dstat = <DroneStatus>status;
        match dstat {
            DroneStatus value => {
                log:printInfo("[Drone Update] " + value.drone_id + ": " + status.toString());
                statusUpdates[value.drone_id] = value;                   
            }
            error err => {
                log:printError("Failed to convert drone update JSON to record type: " + err.message);
            }
        }
    }
}

@grpc:ServiceConfig
service StatusQuery bind statusListener {
    GetDroneStatus(endpoint caller, string droneId) {
        log:printInfo("Querying drone status: " + droneId);
        DroneStatus status;

        match statusUpdates[droneId] {
            DroneStatus value => {
                status = value;
            }
            () => {
                _ = caller->sendError(grpc:NOT_FOUND, "No updates from that drone");
                status = {};
            }
        }

        _ = caller->send(status);
        _ = caller->complete();
    }
}