(function() {
    if (this.as3geolocation) return;
    
    var as3geolocation = this.as3geolocation = {
        swf: null,
        
        assignSwf: function(swfId) {
            this.swf = document.all ? window[swfId] : document[swfId];
        },

        getCurrentPosition: function(successCallback, errorCallback, options) {
            navigator.geolocation.getCurrentPosition(
                function(position) {
                    var returnObject = {
                        "coords": {
                            "latitude": position.coords.latitude,
                            "longitude": position.coords.longitude,
                            "altitude": position.coords.altitude,
                            "accuracy": position.coords.accuracy,
                            "altitudeAccuracy": position.coords.altitudeAccuracy,
                            "heading": position.coords.heading,
                            "speed": position.coords.speed
                            },
                        "timestamp": position.timestamp
                    };

                    as3geolocation.toNativeFunc(as3geolocation.swf, successCallback).apply(null, [returnObject]);
                }, 
                function(error) {
                    var returnObject = {
                        "code": error.code,
                        "message": error.message
                    };

                    as3geolocation.toNativeFunc(as3geolocation.swf, errorCallback).apply(null, [returnObject]);
                }, options);
        },
        
        toNativeFunc: function(obj, functionName) {
            return function() {
                var parameters = [];
                for(var i = 0; i < arguments.length; i++) {
                    parameters[i] = "_" + i;
                }
                
                return Function(
                    parameters.join(','), 
                    'this["' + functionName + '"](' + parameters.join(',') + ')' 
                ).apply(obj, arguments);
            }
        }
    }
})();