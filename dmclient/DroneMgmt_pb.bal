import ballerina/grpc;
import ballerina/io;

public type DroneMgmtBlockingStub object {
    
    public grpc:Client clientEndpoint;
    public grpc:Stub stub;

    function initStub (grpc:Client ep) {
        grpc:Stub navStub = new;
        navStub.initStub(ep, "blocking", DESCRIPTOR_KEY, descriptorMap);
        self.stub = navStub;
    }
    
    public function GetDrone (string req, grpc:Headers? headers = ()) returns ((DroneDetails, grpc:Headers)|error) {
        
        var unionResp = self.stub.blockingExecute("DroneMgmt/GetDrone", req, headers = headers);
        match unionResp {
            error payloadError => {
                return payloadError;
            }
            (any, grpc:Headers) payload => {
                any result;
                grpc:Headers resHeaders;
                (result, resHeaders) = payload;
                return (check <DroneDetails>result, resHeaders);
            }
        }
    }
    
    public function AddDrone (DroneInfo req, grpc:Headers? headers = ()) returns ((DroneInfo, grpc:Headers)|error) {
        
        var unionResp = self.stub.blockingExecute("DroneMgmt/AddDrone", req, headers = headers);
        match unionResp {
            error payloadError => {
                return payloadError;
            }
            (any, grpc:Headers) payload => {
                any result;
                grpc:Headers resHeaders;
                (result, resHeaders) = payload;
                return (check <DroneInfo>result, resHeaders);
            }
        }
    }
    
    public function UpdateDrone (DroneInfo req, grpc:Headers? headers = ()) returns ((DroneInfo, grpc:Headers)|error) {
        
        var unionResp = self.stub.blockingExecute("DroneMgmt/UpdateDrone", req, headers = headers);
        match unionResp {
            error payloadError => {
                return payloadError;
            }
            (any, grpc:Headers) payload => {
                any result;
                grpc:Headers resHeaders;
                (result, resHeaders) = payload;
                return (check <DroneInfo>result, resHeaders);
            }
        }
    }
    
};

public type DroneMgmtStub object {
    
    public grpc:Client clientEndpoint;
    public grpc:Stub stub;

    function initStub (grpc:Client ep) {
        grpc:Stub navStub = new;
        navStub.initStub(ep, "non-blocking", DESCRIPTOR_KEY, descriptorMap);
        self.stub = navStub;
    }
    
    function GetDrone (string req, typedesc listener, grpc:Headers? headers = ()) returns (error?) {
        return self.stub.nonBlockingExecute("DroneMgmt/GetDrone", req, listener, headers = headers);
    }
    
    function AddDrone (DroneInfo req, typedesc listener, grpc:Headers? headers = ()) returns (error?) {
        return self.stub.nonBlockingExecute("DroneMgmt/AddDrone", req, listener, headers = headers);
    }
    
    function UpdateDrone (DroneInfo req, typedesc listener, grpc:Headers? headers = ()) returns (error?) {
        return self.stub.nonBlockingExecute("DroneMgmt/UpdateDrone", req, listener, headers = headers);
    }
    
};


public type DroneMgmtBlockingClient object {
    
    public grpc:Client client;
    public DroneMgmtBlockingStub stub;

    public function init (grpc:ClientEndpointConfig config) {
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(config);
        self.client = c;
        // initialize service stub.
        DroneMgmtBlockingStub s = new;
        s.initStub(c);
        self.stub = s;
    }

    public function getCallerActions () returns (DroneMgmtBlockingStub) {
        return self.stub;
    }
};

public type DroneMgmtClient object {
    
    public grpc:Client client;
    public DroneMgmtStub stub;

    public function init (grpc:ClientEndpointConfig config) {
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(config);
        self.client = c;
        // initialize service stub.
        DroneMgmtStub s = new;
        s.initStub(c);
        self.stub = s;
    }

    public function getCallerActions () returns (DroneMgmtStub) {
        return self.stub;
    }
};


public type DroneDetails record {
    DroneInfo info;
    float latitude;
    float longitude;
    float altitude;
    float battery_remaining;
    
};

public type DroneInfo record {
    string id;
    string name;
    string description;
    
};


@final string DESCRIPTOR_KEY = "target/grpc/DroneMgmt.proto";
map descriptorMap =
{ 
    "target/grpc/DroneMgmt.proto":"0A1B7461726765742F677270632F44726F6E654D676D742E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22B1010A0C44726F6E6544657461696C73121E0A04696E666F18012001280B320A2E44726F6E65496E666F5204696E666F121A0A086C6174697475646518022001280252086C61746974756465121C0A096C6F6E67697475646518032001280252096C6F6E676974756465121A0A08616C7469747564651804200128025208616C746974756465122B0A11626174746572795F72656D61696E696E6718052001280252106261747465727952656D61696E696E6722510A0944726F6E65496E666F120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E328F010A0944726F6E654D676D7412370A0847657444726F6E65121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A0D2E44726F6E6544657461696C7312220A0841646444726F6E65120A2E44726F6E65496E666F1A0A2E44726F6E65496E666F12250A0B55706461746544726F6E65120A2E44726F6E65496E666F1A0A2E44726F6E65496E666F620670726F746F33",
  
    "google.protobuf.wrappers.proto":"0A0E77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
  
};
