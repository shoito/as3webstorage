(function() {
    if (this.as3webstorage) return;
    
    var as3webstorage = this.as3webstorage = {
        swf: null,
        
        assignSwf: function(swfId) {
            this.swf = document.all ? window[swfId] : document[swfId];
        },

        addStorageEventListener: function(callback, useCapture) {
            window.addEventListener("storage", function(event) {
                var returnObject = {
                    "key": event.key,
                    "oldValue": event.oldValue,
                    "newValue": event.newValue,
                    "uri": event.uri,
                    "source": undefined,
                    "storageArea": undefined
                };

                as3webstorage.toNativeFunc(as3webstorage.swf, callback).apply(null, [returnObject]);
            }, useCapture);
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
            };
        }
    };
})();