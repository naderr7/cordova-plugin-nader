#import <Cordova/CDVAvailability.h>
#import "ePOS.h"
#import "naderr.h"

@interface naderPlugin ()
    - (void) sendError:(int)errorStatus textForShow:(NSString*)text command:(CDVInvokedUrlCommand*)command;
    - (void) sendError:(NSString*)text command:(CDVInvokedUrlCommand*)command;
@end


@implementation naderPlugin
/**
 * Find printers and print
 * Sends the printing content to the printer controller and opens them.
 *
 */
  
- (void) getAvailablePrinters:(CDVInvokedUrlCommand*)command
{
    int result = EPOS2_SUCCESS;
    Epos2FilterOption *filterOption = nil;
    filterOption = [[Epos2FilterOption alloc] init];
    filterOption.porttype = EPOS2_PORTTYPE_ALL;
    filterOption.broadcast = @"255.255.255.255"
    filterOption.deviceModel = EPOS2_MODEL_ALL;
    filterOption.deviceType = EPOS2_TYPE_ALL;
    
    result = [Epos2Discovery start:filterOption Delegate:self];
    
    if (result != EPOS2_CODE_SUCCESS) {
    //Displays error messages
         [self sendError:@"printers not found" command:command];
    }
    [Epos2Discovery stop];
}

- (void) onDiscovery:(Epos2DeviceInfo *)deviceInfo
{
     CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsArray:deviceInfo];
     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}






















- (void) print:(CDVInvokedUrlCommand*)command
{
    
   // NSArray * arguments = [command arguments];
   // NSString *contentForPrint = [arguments objectAtIndex:0];
   // NSString *chosenPrinterName = [arguments objectAtIndex:1];
    /*
    int find_printers_status = EPSONIO_OC_SUCCESS;
    find_printers_status = [EpsonIoFinder start:EPSONIO_OC_DEVTYPE_BLUETOOTH FindOption:nil];
    
    [self sendError:find_printers_status textForShow:@"error during printer search" command:command];
    
    int get_printers_list_status = EPSONIO_OC_SUCCESS;
    
    NSArray *printerList_ = [[NSArray alloc]initWithArray:
                            [EpsonIoFinder getDeviceInfoList:&get_printers_list_status
                                           FilterOption:EPSONIO_OC_PARAM_DEFAULT]];
    
    [EpsonIoFinder stop];
    
    NSString* deviceName = nil;
    NSString* printerName = nil;
    
    for (int i = 0; i < [printerList_ count]; i++) {
        
        if ([chosenPrinterName isEqualToString:[[printerList_ objectAtIndex:i] printerName]]) {
            deviceName = [[printerList_ objectAtIndex:i] deviceName];
            printerName = [[printerList_ objectAtIndex:i] printerName];
        }
    }
    
    if (deviceName == nil || printerName == nil) {
        [self sendError:@"printer is unavalibale" command:command];
    } else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                         messageAsString:@"success"];
        
        [self.commandDelegate sendPluginResult:pluginResult
                              callbackId:command.callbackId];
    }
    
    //Initialize an EposBuilder class instance
    id builder = [[EposBuilder alloc] initWithPrinterModel:printerName Lang:EPOS_OC_MODEL_ANK];
    if ( builder == nil ) {
        [self sendError:@"builder initialize error" command:command];
    }
    
    //Create a print document
    int errorStatus = EPOS_OC_SUCCESS;
    errorStatus = [builder addTextLang: EPOS_OC_LANG_EN];
    errorStatus = [builder addTextSmooth: EPOS_OC_TRUE];
    errorStatus = [builder addTextFont: EPOS_OC_FONT_A];
    errorStatus = [builder addTextSize: 3 Height: 3];
    errorStatus = [builder addText: contentForPrint];
    errorStatus = [builder addCut: EPOS_OC_CUT_FEED];
    
    //Initialize an EposPrint class instance
    id printer = [[EposPrint alloc] init];
    unsigned long status;
    
    //Send a print document
    if (printer == nil) {
        [self sendError:@"printer initialize error" command:command];
    }
    
    //<Start communication with the printer>
    errorStatus = [printer openPrinter:EPSONIO_OC_DEVTYPE_BLUETOOTH
                           DeviceName:deviceName Enabled:EPOS_OC_TRUE
                           Interval:EPOS_OC_PARAM_DEFAULT Timeout:EPOS_OC_PARAM_DEFAULT];
    
    //<Send data>
    errorStatus = [printer sendData:builder Timeout:10000 Status:&status];
    
    [self sendError:errorStatus textForShow:@"Failure to send data to printer" command:command];
    
    //<Delete the command buffers>
    if ((status & EPOS_OC_ST_PRINT_SUCCESS) == EPOS_OC_ST_PRINT_SUCCESS) {
        errorStatus = [builder clearCommandBuffer];
    }
    
    //<End communication with the printer>
    errorStatus = [printer closePrinter];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                     messageAsString:@"success"];
    
    [self.commandDelegate sendPluginResult:pluginResult
                          callbackId:command.callbackId];
    */
}
















- (void) sendError:(int)errorStatus textForShow:(NSString*)text command:(CDVInvokedUrlCommand*)command
{
    if (errorStatus != EPOS2_SUCCESS) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                         messageAsString:[NSString stringWithFormat:@"%@%i", text, errorStatus]];
        
        [self.commandDelegate sendPluginResult:pluginResult
                              callbackId:command.callbackId];
    }
}








- (void) sendError:(NSString*)text command:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                     messageAsString:text];
    
    [self.commandDelegate sendPluginResult:pluginResult
                          callbackId:command.callbackId];
}

@end
