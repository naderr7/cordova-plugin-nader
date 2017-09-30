var naderPlugin = function () {

};

naderPlugin.prototype = {
    /**
     * Finds and return available printers.
     *
     * @param {Function} successCallback
     *      returns founded printers array
     * @param {Function?} errorCallback
     *      returns error message
     *
     */
    getAvailablePrinters: function (successCallback, errorCallback) {

        cordova.exec(successCallback, errorCallback, 'naderPlugin', 'getAvailablePrinters', []);
    },

    /**
     * Sends the content to the printer app or service.
     *
     * @param {String} content
     *      HTML string 
     * @param {EpsonIoDeviceInfo} printer
     *      Chosen EpsonIoDeviceInfo-type printer that returns from 
     *      getAvailablePrinters method
     * @param {Function} successCallback
     *      
     * @param {Function} errorCallback
     *      
     */
    print: function (content, printer, successCallback, errorCallback) {
        
        var page = content.innerHTML || content;

        if (typeof page != 'string') {
            console.log('Print function requires an HTML string. Not an object');
            return;
        }

        if (!printer) {
            console.log('Print function requires printer');
            return;
        }

        cordova.exec(successCallback, errorCallback, 'naderPlugin', 'print', [page, printer]);
    }
};

var plugin = new naderPlugin();

module.exports = plugin;
