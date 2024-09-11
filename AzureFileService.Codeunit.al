codeunit 50100 "FNZ Azure File Service"
{
    var
        AzureFileServiceSetup: Record "AKH Azure File Service Setup";

    procedure ReadListFromShare(FilePath: Text; var AFSDirectoryContent: Record "AFS Directory Content")
    var
        AFSFileClient: Codeunit "AFS File Client";
        AFSOperationResponse: Codeunit "AFS Operation Response";
        StorageAccountAutherization: Codeunit "Storage Service Authorization";
    begin
        AzureFileServiceSetup.Get();
        AzureFileServiceSetup.TestField("Storage Account");
        AzureFileServiceSetup.TestField("File Share");
        AzureFileServiceSetup.TestField("Sas Token");
        AFSFileClient.Initialize(AzureFileServiceSetup."Storage Account", AzureFileServiceSetup."File Share",
        StorageAccountAutherization.CreateSharedKey(AzureFileServiceSetup."Sas Token"));
        AFSOperationResponse := AFSFileClient.ListDirectory(FilePath, AFSDirectoryContent);
        if not AFSOperationResponse.IsSuccessful() then
            Error(AFSOperationResponse.GetError());
    end;

    procedure ReadFileFromShare(FilePath: Text; var FileText: Text)
    var
        AFSFileClient: Codeunit "AFS File Client";
        AFSOperationResponse: Codeunit "AFS Operation Response";
        StorageAccountAutherization: Codeunit "Storage Service Authorization";
        Authorization: Interface "Storage Service Authorization";
        FileShare: Text;
        StorageAccount: Text;
    begin
        AzureFileServiceSetup.Get();
        AzureFileServiceSetup.TestField("Storage Account");
        AzureFileServiceSetup.TestField("File Share");
        AzureFileServiceSetup.TestField("Sas Token");

        AFSFileClient.Initialize(AzureFileServiceSetup."Storage Account", AzureFileServiceSetup."File Share",
        StorageAccountAutherization.CreateSharedKey(AzureFileServiceSetup."Sas Token"));

        //AFSOperationResponse := AFSFileClient.GetFileAsStream(FilePath,FileInstream); 
        AFSFileClient.GetFileAsText(FilePath, FileText);
        if not AFSOperationResponse.IsSuccessful() then
            Error(AFSOperationResponse.GetError());
    end;

    procedure MoveFileFromShare(FromFilePath: Text; ToFilePath: Text; FileName: Text; FileText: Text)
    var
        AFSFileClient: Codeunit "AFS File Client";
        AFSOperationResponse: Codeunit "AFS Operation Response";
        StorageAccountAutherization: Codeunit "Storage Service Authorization";
        TempBlob: Codeunit "Temp Blob";
        FileInStream: InStream;
        Authorization: Interface "Storage Service Authorization";
        lblErrorCopyFile: Label 'Error copying file from %1 to %2 \Error message %3', Comment = '%1 = From File Path, %2 = To File Path';
        FileOutStream: OutStream;
        FileShare: Text;
        StorageAccount: Text;
    begin
        FromFilePath := FromFilePath.Replace('\', '/');
        ToFilePath := ToFilePath.Replace('\', '/');
        AzureFileServiceSetup.Get();
        AzureFileServiceSetup.TestField("Storage Account");
        AzureFileServiceSetup.TestField("File Share");
        AzureFileServiceSetup.TestField("Sas Token");

        AFSFileClient.Initialize(AzureFileServiceSetup."Storage Account", AzureFileServiceSetup."File Share",
        StorageAccountAutherization.CreateSharedKey(AzureFileServiceSetup."Sas Token"));
        TempBlob.CreateOutStream(FileOutStream);
        FileOutStream.WriteText(FileText);
        TempBlob.CreateInStream(FileInStream);



        WriteFiletoShare(ToFilePath + '\' + FileName, FileInStream);

        AFSOperationResponse := AFSFileClient.DeleteFile(FromFilePath);
        if not AFSOperationResponse.IsSuccessful() then
            Error(AFSOperationResponse.GetError());
    end;

    procedure WriteFiletoShare(FilePath: Text; var FileContent: InStream)
    var
        AFSFileClient: Codeunit "AFS File Client";
        AFSOperationResponse: Codeunit "AFS Operation Response";
        StorageAccountAutherization: Codeunit "Storage Service Authorization";
        Authorization: Interface "Storage Service Authorization";
        FileShare: Text;
        StorageAccount: Text;
    begin
        AzureFileServiceSetup.Get();
        AzureFileServiceSetup.TestField("Storage Account");
        AzureFileServiceSetup.TestField("File Share");
        AzureFileServiceSetup.TestField("Sas Token");

        AFSFileClient.Initialize(AzureFileServiceSetup."Storage Account", AzureFileServiceSetup."File Share",
        StorageAccountAutherization.CreateSharedKey(AzureFileServiceSetup."Sas Token"));

        AFSOperationResponse := AFSFileClient.CreateFile(FilePath, FileContent);
        if not AFSOperationResponse.IsSuccessful() then
            Error(AFSOperationResponse.GetError());
        AFSOperationResponse := AFSFileClient.PutFileStream(FilePath, FileContent);
        if not AFSOperationResponse.IsSuccessful() then
            Error(AFSOperationResponse.GetError());
    end;
 

}
