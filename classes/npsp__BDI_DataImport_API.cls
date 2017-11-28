/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class BDI_DataImport_API {
    global static String BestMatchOrCreate;
    global static String DoNotMatch;
    global static String ExactMatchOrCreate;
    global static String RequireBestMatch;
    global static String RequireExactMatch;
    global static String RequireNoMatch;
    global BDI_DataImport_API() {

    }
    global static Id importData() {
        return null;
    }
    @InvocableMethod(label='processDataImportBatches' description='starts the batch processing of a list of DataImport batches')
    global static List<npsp.BDI_DataImport_API.ProcessDataImportBatchesResult> processDataImportBatches(List<Id> listBatchId) {
        return null;
    }
global class ProcessDataImportBatchesResult {
    @InvocableVariable( required=false)
    global Id apexJobId;
}
}
