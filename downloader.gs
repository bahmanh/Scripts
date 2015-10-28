* downloader.gs
* To save a given gsheet range in csv format. 
* To be used with Google Apps Scripts
* @author: Bahman
*/

//Create a menu option
function onOpen() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var csvMenuEntries = [{name: "Save as CSV file", functionName: "saveAsCSV"}];
  ss.addMenu("CSV", csvMenuEntries);
}

function saveAsCSV() {
  // Prompts the user for the file name
  //var fileName = Browser.inputBox("Save CSV file as (e.g. myCSVFile):");
  var fileName = "file.csv";
  var folderID = ""; //ID of the G-Drive folder where the file should be saved.
  // Convert the range data to CSV format
  var csvFile = convertRangeToCsvFile_(fileName);
  // Create a file in the given folder (folder ID) with the given name and the CSV data
  DriveApp.getFolderById(folderID).createFile(fileName, csvFile);
}

function convertRangeToCsvFile_(csvFileName) {
  // Get the selected range in the spreadsheet
  var sheet = SpreadsheetApp.getActiveSheet();
  var currentRow = parseInt(PropertiesService.getScriptProperties().getProperty('currentRow'));
 // var ws = SpreadsheetApp.getActiveSheet().getRange(2, 2, numRows ,8);
  try {
     if (currentRow <=  sheet.getLastRow()) {
       //getRange and format to plain text so the dates stay in 00/00/0000 format.
       var data = sheet.getRange(currentRow, 2, sheet.getLastRow()-currentRow+1,8).setNumberFormat('@STRING@').getValues();
       var csvFile = undefined;
    // Loop through the data in the range and build a string with the CSV data
       if (data.length > 0) {
         var csv = "";
         for (var row = 0; row < data.length; row++) {
           for (var col = 0; col < data[row].length; col++) {
             if (data[row][col].toString().indexOf(",") != -1) {
               data[row][col] = "\"" + data[row][col] + "\"";
             }
           }   
           // Join each row's columns
           // Add a carriage return to end of each row, except for the last one
           if (row < data.length-1) {
             csv += data[row].join(",") + "\r\n";
           }
           else {
             csv += data[row];
           }
         }
         csvFile = csv;
       }
       PropertiesService.getScriptProperties().setProperty('currentRow', (sheet.getLastRow()+1).toFixed(0) );
       return csvFile;
    }
  }
  catch(err) {
    Logger.log(err);
    Browser.msgBox(err);
  }
}
