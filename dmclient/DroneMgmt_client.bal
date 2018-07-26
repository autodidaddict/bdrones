import ballerina/io;
import ballerina/grpc;
import ballerina/log;

function main (string... args) {

    endpoint DroneMgmtBlockingClient droneMgmtBlockingEp {
        url:"http://localhost:9090"
    };

    DroneInfo req = {id: "DRONE1", name: "Drone 1", description: "Drone One"};

    var addResponse = droneMgmtBlockingEp->AddDrone(req);
    match addResponse {
        (DroneInfo, grpc:Headers) payload => {
            DroneInfo drone;
            grpc:Headers headers;

            (drone, headers) = payload;
            log:printInfo("Drone " + drone.id + " added.");
        }
        error err => {
            log:printError("Failed to add drone: " + err.message);
        }
    }    

    var detResponse = droneMgmtBlockingEp->GetDrone("DRONE1");
    match detResponse {
        (DroneDetails, grpc:Headers) payload => {
            DroneDetails dets;
            grpc:Headers headers;

            (dets, headers) = payload;
            log:printInfo("Got drone details: " + dets.battery_remaining + "% battery");
        }
        error err => {
            log:printError("Failed to query drone: " + err.message);
        }
    }
}