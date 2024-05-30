/* This script includes resources from Visual Studio 2022 Image Library, the
 * inclusion of which is dictated by the Visual Studio 2022 Image Library EULA:
 *		 https://download.microsoft.com/download/0/6/0/0607D8EA-9BB7-440B-A36A-A24EB8C9C67E/Visual%20Studio%202022%20Image%20Library%20EULA.rtf
 * TL;DR it's totally fine.
 */
;===============================================================================
; SVG Icon map for WindowNotifyOverlay
;===============================================================================
WindowNotifyOverlay.SvgIconMap := WindowNotifyOverlay.MapWith()
.With((self)=>self.CaseSense:=0)
.With((self)=>self.Set(

"Alert.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue{fill: #005dba; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusAlert.18.18</title><title>IconLightStatusAlert.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-blue' d='M10.926,17H8.074l-.707-.293L1.793,11.133,1.5,10.426V7.574l.293-.707L7.367,1.293,8.074,1h2.852l.707.293,5.574,5.574.293.707v2.852l-.293.707-5.574,5.574Z'/><path class='white' d='M10,10H9V4h1Zm-.5,1.75a.75.75,0,1,0,.75.75A.75.75,0,0,0,9.5,11.75Z'/></g></svg>",

"Alert",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue{fill: #005dba; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusAlert</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-blue' d='M8.569,13.5H6.431L5.9,13.28,1.72,9.1,1.5,8.569V6.431L1.72,5.9,5.9,1.72l.531-.22H8.569l.531.22L13.28,5.9l.22.531V8.569l-.22.531L9.1,13.28Z'/><path class='white' d='M8,9H7V4H8Zm-.5.985a.75.75,0,1,0,.75.75A.75.75,0,0,0,7.5,9.985Z'/></g></svg>",

"AlertOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue-10{fill: #005dba; opacity: 0.1;}.light-blue{fill: #005dba; opacity: 1;}</style></defs><title>StatusAlertOutline</title><g id='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-blue-10' d='M13,6.375v2.25L8.625,13H6.375L2,8.625V6.375L6.375,2h2.25Z'/><path class='light-blue' d='M13.354,6.021,8.979,1.646,8.625,1.5H6.375l-.354.146L1.646,6.021,1.5,6.375v2.25l.146.354,4.375,4.375.354.146h2.25l.354-.146,4.375-4.375.146-.354V6.375Zm-.854,2.4L8.418,12.5H6.582L2.5,8.418V6.582L6.582,2.5H8.418L12.5,6.582ZM8,9H7V4H8Zm.25,1.735a.75.75,0,1,1-.75-.75A.75.75,0,0,1,8.25,10.735Z'/></g></svg>",

"Error.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusError.18.18</title><title>StatusError.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-red' d='M9,1a8,8,0,1,0,8,8A8.008,8.008,0,0,0,9,1Z'/><path class='white' d='M9.884,9l3.558,3.558-.884.884L9,9.884,5.442,13.442l-.884-.884L8.116,9,4.558,5.442l.884-.884L9,8.116l3.558-3.558.884.884Z'/></g></svg>",

"Error",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusError</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red' d='M14,7.5A6.5,6.5,0,1,1,7.5,1,6.508,6.508,0,0,1,14,7.5Z'/><path class='white' d='M8.384,7.5l2.808,2.808-.884.884L7.5,8.384,4.692,11.192l-.884-.884L6.616,7.5,3.808,4.692l.884-.884L7.5,6.616l2.808-2.808.884.884Z'/></g></svg>",

"ErrorOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red-10{fill: #c50b17; opacity: 0.1;}.light-red{fill: #c50b17; opacity: 1;}</style></defs><title>IconLightStatusErrorOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red-10' d='M13.5,7.5a6,6,0,1,1-6-6A6,6,0,0,1,13.5,7.5Z'/><path class='light-red' d='M7.5,1A6.5,6.5,0,1,0,14,7.5,6.508,6.508,0,0,0,7.5,1Zm0,12A5.5,5.5,0,1,1,13,7.5,5.506,5.506,0,0,1,7.5,13Z'/><path class='light-red' d='M8.207,7.5l2.4,2.4L9.9,10.6l-2.4-2.4L5.1,10.6,4.4,9.9l2.4-2.4L4.4,5.1,5.1,4.4l2.4,2.4L9.9,4.4,10.6,5.1Z'/></g></svg>",

"Excluded.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusExcluded.18.18</title><title>IconLightStatusExcluded.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-red' d='M9,1a8,8,0,1,0,8,8A8.009,8.009,0,0,0,9,1Z'/><path class='white' d='M14,10H4V8H14Z'/></g></svg>",

"Excluded",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>IconLightStatusExcluded</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red' d='M14,7.5A6.5,6.5,0,1,1,7.5,1,6.508,6.508,0,0,1,14,7.5Z'/><path class='white' d='M11,7V8H4V7Z'/></g></svg>",

"ExcludedOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-defaultgrey-10{fill: #212121; opacity: 0.1;}.light-defaultgrey{fill: #212121; opacity: 1;}</style></defs><title>IconLightStatusExcludedOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-defaultgrey-10' d='M13.5,7.5a6,6,0,1,1-6-6A6,6,0,0,1,13.5,7.5Z'/><path class='light-defaultgrey' d='M7.5,1A6.5,6.5,0,1,0,14,7.5,6.508,6.508,0,0,0,7.5,1Zm0,12A5.5,5.5,0,1,1,13,7.5,5.506,5.506,0,0,1,7.5,13Z'/><path class='light-defaultgrey' d='M11,7V8H4V7Z'/></g></svg>",

"Help.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue{fill: #005dba; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusHelp.18.18</title><title>StatusHelp.18.18</title><g id='canvas'><path class='canvas' d='M18,18.079H-.079V0H18Z'/></g><g id='level-1'><path class='light-blue' d='M8.961,16.874A7.835,7.835,0,1,1,16.8,9.039,7.844,7.844,0,0,1,8.961,16.874Z'/><path class='white' d='M10,13.5a1,1,0,1,1-1-1A1,1,0,0,1,10,13.5Z'/><path class='white' d='M12.164,6.48a2.833,2.833,0,0,0-.924-2.09,3.311,3.311,0,0,0-3.612-.581,2.883,2.883,0,0,0-1.8,2.515H7.181a1.618,1.618,0,0,1,.461-.988,1.888,1.888,0,0,1,1.407-.571,1.838,1.838,0,0,1,1.244.516,1.656,1.656,0,0,1,.518,1.2,1.031,1.031,0,0,1-.213.728A5.821,5.821,0,0,1,9.551,8.293a3.726,3.726,0,0,0-.631.621,3.177,3.177,0,0,0-.433.731,2.363,2.363,0,0,0-.17.925V11H9.658a3.357,3.357,0,0,1,.08-.867,1.215,1.215,0,0,1,.372-.589c.174-.169.351-.33.522-.486C11.488,8.278,12.164,7.663,12.164,6.48Z'/></g></svg>",

"Help",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue{fill: #005dba; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusHelp</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-blue' d='M14,7.5A6.5,6.5,0,1,1,7.5,1,6.508,6.508,0,0,1,14,7.5Z'/><path class='white' d='M7.5,3.781A2.205,2.205,0,0,1,9.688,5.969c0,1.054-.7,1.5-1.3,2.115a1.518,1.518,0,0,0-.454,1.385H7.062a2.814,2.814,0,0,1,.13-1.153,2.794,2.794,0,0,1,.746-1,3.581,3.581,0,0,0,.745-.83,1.275,1.275,0,0,0-.67-1.729,1.313,1.313,0,0,0-1.825,1.21H5.312A2.195,2.195,0,0,1,7.5,3.781ZM8.25,11.5a.75.75,0,1,1-.75-.75A.75.75,0,0,1,8.25,11.5Z'/></g></svg>",

"HelpOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue-10{fill: #005dba; opacity: 0.1;}.light-blue{fill: #005dba; opacity: 1;}</style></defs><title>StatusHelpOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-blue-10' d='M13.5,7.5a6,6,0,1,1-6-6A6,6,0,0,1,13.5,7.5Z'/><path class='light-blue' d='M7.5,1A6.5,6.5,0,1,0,14,7.5,6.508,6.508,0,0,0,7.5,1Zm0,12A5.5,5.5,0,1,1,13,7.5,5.506,5.506,0,0,1,7.5,13Z'/><path class='light-blue' d='M7.5,3.781A2.205,2.205,0,0,1,9.688,5.969c0,1.054-.7,1.5-1.3,2.115a1.518,1.518,0,0,0-.454,1.385H7.062a2.814,2.814,0,0,1,.13-1.153,2.794,2.794,0,0,1,.746-1,3.581,3.581,0,0,0,.745-.83,1.275,1.275,0,0,0-.67-1.729,1.313,1.313,0,0,0-1.825,1.21H5.312A2.195,2.195,0,0,1,7.5,3.781ZM8.25,11.5a.75.75,0,1,1-.75-.75A.75.75,0,0,1,8.25,11.5Z'/></g></svg>",

"Information.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue{fill: #005dba; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusInformation.18.18</title><title>StatusInformation.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-blue' d='M8.5,17a8,8,0,1,1,8-8A8.009,8.009,0,0,1,8.5,17Z'/><path class='white' d='M8,8H9v5H8Zm.5-3.25a.75.75,0,1,0,.75.75A.75.75,0,0,0,8.5,4.75Z'/></g></svg>",

"Information",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue{fill: #005dba; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusInformation</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-blue' d='M14,7.5A6.5,6.5,0,1,1,7.5,1,6.508,6.508,0,0,1,14,7.5Z'/><path class='white' d='M8,11V6H7v5Zm.25-6.75A.75.75,0,1,1,7.5,3.5.75.75,0,0,1,8.25,4.25Z'/></g></svg>",

"InformationOutline.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue-10{fill: #005dba; opacity: 0.1;}.light-blue{fill: #005dba; opacity: 1;}</style></defs><title>StatusInformationOutline.18.18</title><title>StatusInformationOutline.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-blue-10' d='M8.5,16.5A7.5,7.5,0,1,1,16,9,7.509,7.509,0,0,1,8.5,16.5Z'/><path class='light-blue' d='M8.5,17a8,8,0,1,1,8-8A8.009,8.009,0,0,1,8.5,17Zm0-15a7,7,0,1,0,7,7A7.008,7.008,0,0,0,8.5,2Z'/><path class='light-blue' d='M8,8.025H9V14H8ZM8.5,4.9a.75.75,0,1,0,.75.75A.75.75,0,0,0,8.5,4.9Z'/></g></svg>",

"InformationOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue-10{fill: #005dba; opacity: 0.1;}.light-blue{fill: #005dba; opacity: 1;}</style></defs><title>StatusInformationOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-blue-10' d='M13.5,7.5a6,6,0,1,1-6-6A6,6,0,0,1,13.5,7.5Z'/><path class='light-blue' d='M7.5,1A6.5,6.5,0,1,0,14,7.5,6.508,6.508,0,0,0,7.5,1Zm0,12A5.5,5.5,0,1,1,13,7.5,5.506,5.506,0,0,1,7.5,13Z'/><path class='light-blue' d='M8,11V6H7v5Zm.25-6.5a.75.75,0,1,1-.75-.75A.75.75,0,0,1,8.25,4.5Z'/></g></svg>",

"Invalid.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusInvalid.18.18</title><title>IconLightStatusInvalid.18.18</title><g id='canvas'><path class='canvas' d='M0,0H18V18H0Z'/></g><g id='level-1'><path class='light-red' d='M8.5,1a8,8,0,1,1-8,8A8.009,8.009,0,0,1,8.5,1Z'/><path class='white' d='M9,11H8V5H9Zm-.5,1.75a.75.75,0,1,0,.75.75A.75.75,0,0,0,8.5,12.75Z'/></g></svg>",

"Invalid",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>IconLightStatusInvalid</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red' d='M14,7.5A6.5,6.5,0,1,1,7.5,1,6.508,6.508,0,0,1,14,7.5Z'/><path class='white' d='M7,4V9H8V4Zm1.25,7a.75.75,0,1,1-.75-.75A.75.75,0,0,1,8.25,11Z'/></g></svg>",

"InvalidOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red-10{fill: #c50b17; opacity: 0.1;}.light-red{fill: #c50b17; opacity: 1;}</style></defs><title>IconLightStatusInvalidOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red-10' d='M13.5,7.5a6,6,0,1,1-6-6A6,6,0,0,1,13.5,7.5Z'/><path class='light-red' d='M7.5,1A6.5,6.5,0,1,0,14,7.5,6.508,6.508,0,0,0,7.5,1Zm0,12A5.5,5.5,0,1,1,13,7.5,5.506,5.506,0,0,1,7.5,13Z'/><path class='light-red' d='M7,4V9H8V4Zm1.25,6.5a.75.75,0,1,1-.75-.75A.75.75,0,0,1,8.25,10.5Z'/></g></svg>",

"No.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-red-10{fill: #c50b17; opacity: 0.1;}.light-red{fill: #c50b17; opacity: 1;}</style></defs><title>StatusNo.18.18</title><title>IconLightStatusNo.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-red-10' d='M16.5,9A7.5,7.5,0,1,1,9,1.5,7.5,7.5,0,0,1,16.5,9Z'/><path class='light-red' d='M9,1a8,8,0,1,0,8,8A8.009,8.009,0,0,0,9,1ZM2,9A6.963,6.963,0,0,1,3.716,4.423l9.861,9.861A6.99,6.99,0,0,1,2,9Zm12.284,4.577L4.423,3.716a6.99,6.99,0,0,1,9.861,9.861Z'/></g></svg>",

"No",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}</style></defs><title>IconLightStatusNo</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red' d='M8,1a7,7,0,1,0,7,7A7.009,7.009,0,0,0,8,1ZM3,8a4.969,4.969,0,0,1,.833-2.753l6.92,6.92A4.992,4.992,0,0,1,3,8Zm9.167,2.753-6.92-6.92a4.992,4.992,0,0,1,6.92,6.92Z'/></g></svg>",

"NoOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-defaultgrey-10{fill: #212121; opacity: 0.1;}.light-defaultgrey{fill: #212121; opacity: 1;}</style></defs><title>IconLightStatusNoOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-defaultgrey-10' d='M13.5,7.5a6,6,0,1,1-6-6A6,6,0,0,1,13.5,7.5Z'/><path class='light-defaultgrey' d='M7.5,1A6.5,6.5,0,1,0,14,7.5,6.508,6.508,0,0,0,7.5,1Zm0,12A5.5,5.5,0,1,1,13,7.5,5.506,5.506,0,0,1,7.5,13Z'/><path class='light-defaultgrey' d='M11.724,11.017a5.621,5.621,0,0,1-.707.707L3.276,3.983a5.621,5.621,0,0,1,.707-.707Z'/></g></svg>",

"Offline.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}</style></defs><title>StatusOffline.18.18</title><title>IconLightStatusOffline.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-red' d='M9.707,9l4.147,4.146-.708.708L9,9.707,4.854,13.854l-.708-.708L8.293,9,4.146,4.854l.708-.708L9,8.293l4.146-4.147.708.708Z'/></g></svg>",

"Offline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}</style></defs><title>StatusOffline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red' d='M8.207,7.5l3.4,3.4L10.9,11.6l-3.4-3.4L4.1,11.6,3.4,10.9l3.4-3.4L3.4,4.1,4.1,3.4l3.4,3.4,3.4-3.4L11.6,4.1Z'/></g></svg>",

"OK.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-green{fill: #1f801f; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusOK.18.18</title><title>IconLightStatusOK.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-green' d='M17,9A8,8,0,1,1,9,1,8.008,8.008,0,0,1,17,9Z'/><path class='white' d='M8,12.207,4.646,8.854l.708-.708L8,10.793l5.146-5.147.708.708Z'/></g></svg>",

"OK",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-green{fill: #1f801f; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>IconLightStatusOK</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-green' d='M14,7.5A6.5,6.5,0,1,1,7.5,1,6.508,6.508,0,0,1,14,7.5Z'/><path class='white' d='M11.354,5.854l-4.5,4.5H6.146l-2.5-2.5.708-.708L6.5,9.293l4.146-4.147Z'/></g></svg>",

"OKOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-green-10{fill: #1f801f; opacity: 0.1;}.light-green{fill: #1f801f; opacity: 1;}</style></defs><title>IconLightStatusOKOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-green-10' d='M13.5,7.5a6,6,0,1,1-6-6A6,6,0,0,1,13.5,7.5Z'/><path class='light-green' d='M7.5,1A6.5,6.5,0,1,0,14,7.5,6.508,6.508,0,0,0,7.5,1Zm0,12A5.5,5.5,0,1,1,13,7.5,5.506,5.506,0,0,1,7.5,13Z'/><path class='light-green' d='M11.354,5.854l-4.5,4.5H6.146l-2.5-2.5.708-.708L6.5,9.293l4.146-4.147Z'/></g></svg>",

"Paused.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue{fill: #005dba; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusPaused.18.18</title><title>IconLightStatusPaused.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-blue' d='M9,1a8,8,0,1,0,8,8A8.008,8.008,0,0,0,9,1Z'/><path class='white' d='M7,12H6V6H7Z'/><path class='white' d='M12,12H11V6h1Z'/></g></svg>",

"Paused",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue{fill: #005dba; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusPaused</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-blue' d='M14,7.5A6.5,6.5,0,1,1,7.5,1,6.508,6.508,0,0,1,14,7.5Z'/><path class='white' d='M6,10H5V5H6Zm4,0H9V5h1Z'/></g></svg>",

"PausedOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-blue-10{fill: #005dba; opacity: 0.1;}.light-blue{fill: #005dba; opacity: 1;}</style></defs><title>StatusPausedOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-blue-10' d='M13.5,7.5a6,6,0,1,1-6-6A6,6,0,0,1,13.5,7.5Z'/><path class='light-blue' d='M7.5,1A6.5,6.5,0,1,0,14,7.5,6.508,6.508,0,0,0,7.5,1Zm0,12A5.5,5.5,0,1,1,13,7.5,5.506,5.506,0,0,1,7.5,13Z'/><path class='light-blue' d='M6,10H5V5H6Zm4,0H9V5h1Z'/></g></svg>",

"Required",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusRequired</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red' d='M14,7.5A6.5,6.5,0,1,1,7.5,1,6.508,6.508,0,0,1,14,7.5Z'/><path class='white' d='M10.935,6.444,8.594,7.5,10.93,8.557l-.8,1.391-2.084-1.5L8.3,11H6.7l.249-2.553-2.084,1.5-.8-1.391L6.406,7.5,4.068,6.443l.8-1.391,2.084,1.5L6.7,4H8.3L8.051,6.553l2.084-1.5Z'/></g></svg>",

"RequiredOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red-10{fill: #c50b17; opacity: 0.1;}.light-red{fill: #c50b17; opacity: 1;}</style></defs><title>StatusRequiredOutline</title><g id='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red-10' d='M13.5,7.5a6,6,0,1,1-6-6A6.006,6.006,0,0,1,13.5,7.5Z'/><path class='light-red' d='M7.5,14A6.5,6.5,0,1,1,14,7.5,6.508,6.508,0,0,1,7.5,14Zm0-12A5.5,5.5,0,1,0,13,7.5,5.507,5.507,0,0,0,7.5,2Z'/><path class='light-red' d='M10.935,6.444,8.594,7.5,10.93,8.557l-.8,1.391-2.084-1.5L8.3,11H6.7l.249-2.553-2.084,1.5-.8-1.391L6.406,7.5,4.068,6.443l.8-1.391,2.084,1.5L6.7,4H8.3L8.051,6.553l2.084-1.5Z'/></g></svg>",

"Running.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-green{fill: #1f801f; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusRunning.18.18</title><title>IconLightStatusRunning.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-green' d='M9,2a7,7,0,1,0,7,7A7.006,7.006,0,0,0,9,2Z'/><path class='white' d='M7,12.5v-7l5.5,3.477Z'/></g></svg>",

"Running",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-green{fill: #1f801f; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>IconLightStatusRunning</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-green' d='M14,7.5A6.5,6.5,0,1,1,7.5,1,6.508,6.508,0,0,1,14,7.5Z'/><path class='white' d='M10.5,7.5,6,10.5v-6Z'/></g></svg>",

"RunningOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-green-10{fill: #1f801f; opacity: 0.1;}.light-green{fill: #1f801f; opacity: 1;}</style></defs><title>IconLightStatusRunningOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-green-10' d='M13.5,7.5a6,6,0,1,1-6-6A6,6,0,0,1,13.5,7.5Z'/><path class='light-green' d='M7.5,1A6.5,6.5,0,1,0,14,7.5,6.508,6.508,0,0,0,7.5,1Zm0,12A5.5,5.5,0,1,1,13,7.5,5.506,5.506,0,0,1,7.5,13Z'/><path class='light-green' d='M10.5,7.5,6,10.5v-6Z'/></g></svg>",

"SecurityCritical",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>IconLightStatusSecurityCritical</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red' d='M7.754,14.713H7.246q-.756-.445-1.505-.953C3.083,11.958.987,9.512,1,6.3V3.1l.5-.5a6.869,6.869,0,0,0,2.684-.42,16.06,16.06,0,0,1,2-.992,4.583,4.583,0,0,1,2.637,0A5.108,5.108,0,0,1,10,1.752a6.082,6.082,0,0,0,3.5.848l.5.5V6.3a7.231,7.231,0,0,1-.956,3.608A13.9,13.9,0,0,1,7.754,14.713Z'/><path class='white' d='M8.207,7.5l2.4,2.4L9.9,10.6l-2.4-2.4L5.1,10.6,4.4,9.9l2.4-2.4L4.4,5.1,5.1,4.4l2.4,2.4L9.9,4.4,10.6,5.1Z'/></g></svg>",

"SecurityOK",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-green{fill: #1f801f; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>IconLightStatusSecurityOK</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-green' d='M7.754,14.713H7.246q-.756-.445-1.505-.953C3.083,11.958.987,9.512,1,6.3V3.1l.5-.5a6.869,6.869,0,0,0,2.684-.42,16.06,16.06,0,0,1,2-.992,4.583,4.583,0,0,1,2.637,0A5.108,5.108,0,0,1,10,1.752a6.082,6.082,0,0,0,3.5.848l.5.5V6.3a7.231,7.231,0,0,1-.956,3.608A13.9,13.9,0,0,1,7.754,14.713Z'/><path class='white' d='M11.854,6.1l-4.5,4.5H6.646l-2.5-2.5L4.854,7.4,7,9.543,11.146,5.4Z'/></g></svg>",

"SecurityWarning",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-yellow{fill: #996f00; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>IconLightStatusSecurityWarning</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-yellow' d='M7.754,14.713H7.246q-.756-.445-1.505-.953C3.083,11.958.987,9.512,1,6.3V3.1l.5-.5a6.869,6.869,0,0,0,2.684-.42,16.06,16.06,0,0,1,2-.992,4.583,4.583,0,0,1,2.637,0A5.108,5.108,0,0,1,10,1.752a6.082,6.082,0,0,0,3.5.848l.5.5V6.3a7.231,7.231,0,0,1-.956,3.608A13.9,13.9,0,0,1,7.754,14.713Z'/><path class='white' d='M7.5,11.25a.75.75,0,1,1,.75-.75A.75.75,0,0,1,7.5,11.25ZM7,4V8.5H8V4Z'/></g></svg>",

"Stopped.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusStopped.18.18</title><title>IconLightStatusStopped.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-red' d='M9,17a8,8,0,1,1,8-8A8.009,8.009,0,0,1,9,17Z'/><path class='white' d='M6,6h6v6H6Z'/></g></svg>",

"Stopped",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-red{fill: #c50b17; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>IconLightStatusStopped</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-red' d='M14,7.5A6.5,6.5,0,1,1,7.5,1,6.508,6.508,0,0,1,14,7.5Z'/><path class='white' d='M10,5v5H5V5Z'/></g></svg>",

"StoppedOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-defaultgrey-10{fill: #212121; opacity: 0.1;}.light-defaultgrey{fill: #212121; opacity: 1;}</style></defs><title>IconLightStatusStoppedOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-defaultgrey-10' d='M13.5,7.5a6,6,0,1,1-6-6A6,6,0,0,1,13.5,7.5Z'/><path class='light-defaultgrey' d='M7.5,1A6.5,6.5,0,1,0,14,7.5,6.508,6.508,0,0,0,7.5,1Zm0,12A5.5,5.5,0,1,1,13,7.5,5.506,5.506,0,0,1,7.5,13Z'/><path class='light-defaultgrey' d='M10,5v5H5V5Z'/></g></svg>",

"Warning.18.18",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'><defs><style>.canvas{fill: none; opacity: 0;}.light-yellow{fill: #996f00; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>StatusWarning.18.18</title><title>IconLightStatusWarning.18.18</title><g id='canvas'><path class='canvas' d='M18,18H0V0H18Z'/></g><g id='level-1'><path class='light-yellow' d='M16.708,16H2.292L1.5,14.633,8.708,1.2h1.584L17.5,14.633Z'/><path class='white' d='M10,11H9V5h1Zm-.5,1.75a.75.75,0,1,0,.75.75A.75.75,0,0,0,9.5,12.75Z'/></g></svg>",

"Warning",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-yellow{fill: #996f00; opacity: 1;}.white{fill: #ffffff; opacity: 1;}</style></defs><title>IconLightStatusWarning</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-yellow' d='M14.444,14.27,14,15H1l-.444-.73,6.5-12.5h.888Z'/><path class='white' d='M7.5,13.25a.75.75,0,1,1,.75-.75A.75.75,0,0,1,7.5,13.25ZM7,6v4.5H8V6Z'/></g></svg>",

"WarningOutline",
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><defs><style>.canvas{fill: none; opacity: 0;}.light-yellow-10{fill: #996f00; opacity: 0.1;}.light-yellow{fill: #996f00; opacity: 1;}</style></defs><title>IconLightStatusWarningOutline</title><g id='canvas' class='canvas'><path class='canvas' d='M16,16H0V0H16Z'/></g><g id='level-1'><path class='light-yellow-10' d='M14,14.5H1L7.5,2Z'/><path class='light-yellow' d='M7.944,1.77H7.056l-6.5,12.5L1,15H14l.444-.73ZM1.824,14,7.5,3.084,13.176,14Z'/><path class='light-yellow' d='M7.5,13.25a.75.75,0,1,1,.75-.75A.75.75,0,0,1,7.5,13.25ZM7,6v4.5H8V6Z'/></g></svg>",
))
.With((self)=>self.Set(
	; additional aliases being assigned to existing items, while still being
	; in the same statement
	"!18",		self["Alert.18.18"],
	"!",		self["Alert"],
	"!O",		self["AlertOutline"],
	"E18",		self["Error.18.18"],
	"E",		self["Error"],
	"EO",		self["ErrorOutline"],
	"-18",		self["Excluded.18.18"],
	"-",		self["Excluded"],
	"-O",		self["ExcludedOutline"],
	"?18",		self["Help.18.18"],
	"?",		self["Help"],
	"?O",		self["HelpOutline"],
	"I18",		self["Information.18.18"],
	"I",		self["Information"],
	"IO18",		self["InformationOutline.18.18"],
	"IO",		self["InformationOutline"],
	"Inv18",	self["Invalid.18.18"],
	"Inv",		self["Invalid"],
	"InvO",		self["InvalidOutline"],
	"No18",		self["No.18.18"],
	"No",		self["No"],
	"NoO",		self["NoOutline"],
	"Off18",	self["Offline.18.18"],
	"Off",		self["Offline"],
	"OK18",		self["OK.18.18"],
	"OK",		self["OK"],
	"OKO",		self["OKOutline"],
	"PP10",		self["Paused.18.18"],
	"PP",		self["Paused"],
	"PPO",		self["PausedOutline"],
	"*",		self["Required"],
	"*O",		self["RequiredOutline"],
	"RR18",		self["Running.18.18"],
	"RR",		self["Running"],
	"RRO",		self["RunningOutline"],
	"SC",		self["SecurityCritical"],
	"SO",		self["SecurityOK"],
	"SW",		self["SecurityWarning"],
	"PS18",		self["Stopped.18.18"],
	"PS",		self["Stopped"],
	"PSO",		self["StoppedOutline"],
	"W18",		self["Warning.18.18"],
	"W",		self["Warning"],
	"WO",		self["WarningOutline"],
))

;===============================================================================
; Theme association map for WindowNotifyOverlay
;===============================================================================
WindowNotifyOverlay.PopupThemeAssocMap := WindowNotifyOverlay.MapWith()
.With((self) => self.CaseSense := 0)
.With((self) => self.Set(
	"Alert.18.18",				"info",		"!18",		"info",
	"Alert",					"info",		"!",		"info",
	"AlertOutline",				"info",		"!O",		"info",
	"Error.18.18",				"error",	"E18",		"error",
	"Error",					"error",	"E",		"error",
	"ErrorOutline",				"error",	"EO",		"error",
	"Excluded.18.18",			"error",	"-18",		"error",
	"Excluded",					"error",	"-",		"error",
	"ExcludedOutline",			"error",	"-O",		"error",
	"Help.18.18",				"info",		"?18",		"info",
	"Help",						"info",		"?",		"info",
	"HelpOutline",				"info",		"?O",		"info",
	"Information.18.18",		"info",		"I18",		"info",
	"Information",				"info",		"I",		"info",
	"InformationOutline.18.18",	"info",		"IO18",		"info",
	"InformationOutline",		"info",		"IO",		"info",
	"Invalid.18.18",			"warning",	"Inv18",	"warning",
	"Invalid",					"warning",	"Inv",		"warning",
	"InvalidOutline",			"warning",	"InvO",		"warning",
	"No.18.18",					"warning",	"No18",		"warning",
	"No",						"warning",	"No",		"warning",
	"NoOutline",				"warning",	"NoO",		"warning",
	"Offline.18.18",			"error",	"Off18",	"error",
	"Offline",					"error",	"Off",		"error",
	"OK.18.18",					"message",	"OK18",		"message",
	"OK",						"message",	"OK",		"message",
	"OKOutline",				"message",	"OKO",		"message",
	"Paused.18.18",				"default",	"PP10",		"default",
	"Paused",					"default",	"PP",		"default",
	"PausedOutline",			"default",	"PPO",		"default",
	"Required",					"warning",	"*",		"warning",
	"RequiredOutline",			"warning",	"*O",		"warning",
	"Running.18.18",			"default",	"RR18",		"default",
	"Running",					"default",	"RR",		"default",
	"RunningOutline",			"default",	"RRO",		"default",
	"SecurityCritical",			"error",	"SC",		"error",
	"SecurityOK",				"message",	"SO",		"message",
	"SecurityWarning",			"warning",	"SW",		"warning",
	"Stopped.18.18",			"default",	"PS18",		"default",
	"Stopped",					"default",	"PS",		"default",
	"StoppedOutline",			"default",	"PSO",		"default",
	"Warning.18.18",			"warning",	"W18",		"warning",
	"Warning",					"warning",	"W",		"warning",
	"WarningOutline",			"warning",	"WO",		"warning",
))
