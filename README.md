> :information_source:<br>
> This SDK is implementing the **V1 API** version of GameAnalytics.<br>
> It will still work and result in great analytics to view in our tool!<br>
> The **V2 API** add features like progression, validated purchases and virtual currency tracking.<br>
> Read this [SDK update FAQ](http://www.gameanalytics.com/docs/sdk-update-faq/) to keep yourself informed about future V2 SDK updates.

<br>

### Recent Changes:

##### v.2.0.0:

- Implemented the switchToIDFV for the mobile version. This will use the IDFV instead of IDFA as the device id. If you do NOT have any ads in your application, you should use IDFV as the device identifier. ios_id is NOT send in this case in the startup user event.
- Send timer is now reset after sending data manually with sendData(); The data send interval is increased from 5 to 7 seconds to allow longer response times on slow connections
- Fixed the unhandled ioError exception that happened after trying to send data with an invalid game id

##### v.2.0.1
- Compatible with new version of DeviceId

##### v.2.0.2
- Added ability to override platform, deviceName and osVersion while setting up the mobile Analytics.
