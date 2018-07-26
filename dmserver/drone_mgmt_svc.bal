import ballerina/grpc;
import ballerina/log;

endpoint grpc:Listener listener {
    host: "localhost",
    port: 9090
};

endpoint StatusQueryBlockingClient statusQueryBlockingEp {
        url:"http://localhost:9091"
};

map <DroneInfo> dronesMap;

type DroneInfo record {
    string id;
    string name;
    string description;
};

type DroneDetails record {
    DroneInfo info;
    float latitude;
    float longitude;
    float altitude;
    float battery_remaining;
};

@grpc:ServiceConfig
service DroneMgmt bind listener {

    GetDrone(endpoint caller, string droneId) {        
        log:printInfo("Querying drone: " + droneId);
        DroneDetails details;        

        match dronesMap[droneId] {
            DroneInfo value => {
                details.info = value;
                var status = statusQueryBlockingEp->GetDroneStatus(droneId);
                match status {
                    (DroneStatus, grpc:Headers) payload => {
                        DroneStatus dstat;
                        grpc:Headers headers;

                        (dstat, headers) = payload;                        
                        details.latitude = dstat.latitude;
                        details.longitude = dstat.longitude;
                        details.altitude = dstat.altitude;
                        details.battery_remaining = dstat.battery_remaining;
                    }                    
                    error err => {
                        log:printError("Failed to get drone status: " + err.message);
                    }                    
                }                                
            }
            () => {
                _ = caller->sendError(grpc:NOT_FOUND, "No such drone");
                details = {};
            }
        }        

        _ = caller->send(details);        
        _ = caller->complete();
    }

    AddDrone(endpoint caller, DroneInfo addDroneRequest) {
        DroneInfo response;
        log:printInfo("Adding drone " + addDroneRequest.id + ".");
        string droneId = addDroneRequest.id;
        dronesMap[droneId] = addDroneRequest;

        match dronesMap[droneId] {
            DroneInfo value => {
                response = value;
            }
            () => {
                _ = caller->sendError(grpc:DATA_LOSS, "Failed to store new drone");
                response = {};
            } 
        }
        
        _ = caller->send(response);
        _ = caller->complete();
    }

    UpdateDrone(endpoint caller, DroneInfo updateDroneRequest) {        
        DroneInfo response;
        string droneId = updateDroneRequest.id;        
        
        if (dronesMap.hasKey(droneId)) {
            dronesMap[droneId] = updateDroneRequest; 
            match dronesMap[droneId] {
                DroneInfo value => {
                    response = value;
                } 
                () => {
                    response = {};
                    _ = caller->sendError(grpc:DATA_LOSS, "Failed to store updated drone");
                }
            }            
        } else {
            _ = caller->sendError(grpc:NOT_FOUND, "No such drone");
        }        
        _ = caller->send(response);
        _ = caller ->complete();
    }
}
