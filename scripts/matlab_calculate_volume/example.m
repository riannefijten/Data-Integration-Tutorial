%% Check if DicomFileInterface is available
addpath(genpath('C:\Users\johan.vansoest\Documents\Repositories\DicomFileInterface'))
addpath(genpath('C:\Users\johan.vansoest\Documents\Repositories\SparqlMatlab'))
clc;
clear all;

dataLocation = 'C:\StandAlone\CTP\ctpData\roots\DirectoryStorageService\';
sparqlEndpoint = 'http://localhost:9999/blazegraph/namespace/kb/sparql';
codeVersion = 'ade2c43b60';
startDateString = datestr(datetime('now'), 'dd-mm-yyyy HH:MM:ss');

try 
    DicomObj();
catch 
    disp('Please checkout the DicomFileInterface repository and add to path');
    return;
end

%% Read study folders
studyFolders = dir(dataLocation);
studyFolders = studyFolders(3:size(studyFolders,1)); %remove . and ..

for j = 1:size(studyFolders, 1)
    %% place holders for SPARQL data
    dataLocationStudy = fullfile(dataLocation, studyFolders(j).name);
    ctFolder = fullfile(dataLocationStudy, 'CT');

    folder = fullfile(dataLocationStudy, 'RTSTRUCT');
    
    %if folder of ct and struct both do not exist, skip
    if ~(exist(ctFolder, 'dir') && exist(folder, 'dir'))
        continue
    end
    
    dirInfo = dir([folder '\*.dcm']);
    rtStructPath = fullfile(folder, dirInfo(1).name);

    % Read CT folder
    ctScan =CtScan(ctFolder, false);
    % Read RTStruct file
    rtStruct = RtStruct(rtStructPath, true);

    for i = 1:size(rtStruct.contourNames,1)
        contourName = rtStruct.contourNames{i};
        contour = createContour(rtStruct, contourName);
        refImage = createImageFromCt(ctScan, true);
        voi = createVolumeOfInterest(contour, refImage);

        ExportVolumeSparqlMatlab(sparqlEndpoint, rtStruct.sopInstanceUid, contourName, voi.volume, codeVersion, startDateString);
    end
end