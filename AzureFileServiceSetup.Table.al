table 50100 "AKH Azure File Service Setup"

{
    Caption = 'Azure File Service Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Storage Account"; Text[250])
        {
            Caption = 'Storage Account';
            DataClassification = CustomerContent;
        }
        field(3; "File Share"; Text[250])
        {
            Caption = 'File Share';
            DataClassification = CustomerContent;

        }
        field(4; "Sas Token"; Text[250])
        {
            Caption = 'Sas Token';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
        }
        field(5; "Azure Folder";Text[250])
        {
            Caption = 'Azure File Folder';
            DataClassification = CustomerContent;
        }
        field(6; "Azure Processed Folder";Text[250])
        {
            Caption = 'Azure File Processed Folder';
            DataClassification = CustomerContent;
        }
        
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
