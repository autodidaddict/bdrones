import ballerina/grpc;
import ballerina/io;

public type StatusQueryBlockingStub object {
    
    public grpc:Client clientEndpoint;
    public grpc:Stub stub;

    function initStub (grpc:Client ep) {
        grpc:Stub navStub = new;
        navStub.initStub(ep, "blocking", DESCRIPTOR_KEY, descriptorMap);
        self.stub = navStub;
    }
    
    function GetDroneStatus (string req, grpc:Headers? headers = ()) returns ((DroneStatus, grpc:Headers)|error) {
        
        var unionResp = self.stub.blockingExecute("locserver.StatusQuery/GetDroneStatus", req, headers = headers);
        match unionResp {
            error payloadError => {
                return payloadError;
            }
            (any, grpc:Headers) payload => {
                any result;
                grpc:Headers resHeaders;
                (result, resHeaders) = payload;
                return (check <DroneStatus>result, resHeaders);
            }
        }
    }
    
};

public type StatusQueryStub object {
    
    public grpc:Client clientEndpoint;
    public grpc:Stub stub;

    function initStub (grpc:Client ep) {
        grpc:Stub navStub = new;
        navStub.initStub(ep, "non-blocking", DESCRIPTOR_KEY, descriptorMap);
        self.stub = navStub;
    }
    
    function GetDroneStatus (string req, typedesc listener, grpc:Headers? headers = ()) returns (error?) {
        return self.stub.nonBlockingExecute("locserver.StatusQuery/GetDroneStatus", req, listener, headers = headers);
    }
    
};


public type StatusQueryBlockingClient object {
    
    public grpc:Client client;
    public StatusQueryBlockingStub stub;

    public function init (grpc:ClientEndpointConfig config) {
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(config);
        self.client = c;
        // initialize service stub.
        StatusQueryBlockingStub s = new;
        s.initStub(c);
        self.stub = s;
    }

    public function getCallerActions () returns (StatusQueryBlockingStub) {
        return self.stub;
    }
};

public type StatusQueryClient object {
    
    public grpc:Client client;
    public StatusQueryStub stub;

    public function init (grpc:ClientEndpointConfig config) {
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(config);
        self.client = c;
        // initialize service stub.
        StatusQueryStub s = new;
        s.initStub(c);
        self.stub = s;
    }

    public function getCallerActions () returns (StatusQueryStub) {
        return self.stub;
    }
};


type DroneStatus record {
    string drone_id;
    float latitude;
    float longitude;
    float altitude;
    float battery_remaining;
    
};


@final string DESCRIPTOR_KEY = "locserver.target/grpc/StatusQuery.proto";
map descriptorMap =
{ 
    "locserver.target/grpc/StatusQuery.proto":"0A1D7461726765742F677270632F53746174757351756572792E70726F746F12096C6F637365727665721A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22AB010A0B44726F6E6553746174757312190A0864726F6E655F6964180120012809520764726F6E654964121A0A086C6174697475646518022001280252086C61746974756465121C0A096C6F6E67697475646518032001280252096C6F6E676974756465121A0A08616C7469747564651804200128025208616C746974756465122B0A11626174746572795F72656D61696E696E6718052001280252106261747465727952656D61696E696E6732550A0B537461747573517565727912460A0E47657444726F6E65537461747573121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A162E6C6F637365727665722E44726F6E65537461747573620670726F746F33",
  
    "google.protobuf.wrappers.proto":"0A0E77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
  
};
