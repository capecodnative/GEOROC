% Define the paths for the data files and the settings file
PrimaryFilepath = './ExtractedData/dataverse_files_rocks/2023-12-2JETOA_ADAKITE_extracted.csv';
PrimarySettingsPath = './Settings/rocks.csv';
FilterReportPath = './Settings/rockImporReport.txt';

% Import Parameters and Sites with settings and store the returned tables
GEOROCrocks = importTableWithSettings(PrimaryFilepath, PrimarySettingsPath);
%GEOROCrocks = filterTableBasedOnSettings(GEOROCrocks,PrimarySettingsPath,FilterReportPath);

clear PrimarySettingsPath PrimaryFilepath FilterReportPath