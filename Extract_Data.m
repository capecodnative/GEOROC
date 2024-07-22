% Define the subdirectory path for reading
inputSubdirectoryPath = './SourceData/dataverse_files_minerals/';

% Define the output subdirectory path
outputSubdirectoryPath = './ExtractedData/dataverse_files_minerals/';

% Ensure the output directory exists, create if it doesn't
if ~exist(outputSubdirectoryPath, 'dir')
    mkdir(outputSubdirectoryPath);
end

% Read all CSV files in the input directory and extract all lines before the first empty line
% Get a list of all CSV files in the input directory
csvFiles = dir(fullfile(inputSubdirectoryPath, '*.csv'));

% Display the total number of files to be processed
disp(['Total files to process: ', num2str(numel(csvFiles))]);

% Initialize the timer
updateTimer = tic;

for i = 1:numel(csvFiles)
    % Open the input CSV file for reading
    fid = fopen(fullfile(inputSubdirectoryPath, csvFiles(i).name), 'r');
    
    % Prepare the output file path
    [~, fileName, ~] = fileparts(csvFiles(i).name);
    outputFilePath = fullfile(outputSubdirectoryPath, [fileName, '_extracted.csv']);
    
    % Initialize a cell array to store lines until a blank line is encountered
    lines = {};
    line = fgetl(fid);
    while ischar(line)
        % Check for update every two seconds during file processing
        if toc(updateTimer) >= 2
            disp(['Still processing file ', num2str(i), ' of ', num2str(numel(csvFiles)), ': ', csvFiles(i).name]);
            updateTimer = tic; % Reset the timer
        end
        
        if isempty(line) % Check for the first blank line
            break; % Exit the loop if a blank line is found
        end
        lines{end+1} = line; % Store the line
        line = fgetl(fid); % Read the next line
    end
    
    % Close the input file
    fclose(fid);
    
    % Process the stored lines if necessary
    processedLines = lines; % Placeholder for actual processing
    
    % Open the output CSV file for writing
    fidOut = fopen(outputFilePath, 'w');
    
    % Write all processed lines to the output file
    for j = 1:length(processedLines)
        fprintf(fidOut, '%s\n', processedLines{j});
    end
    
    % Close the output file
    fclose(fidOut);
    
    % Display file completion message
    disp(['Completed processing file ', num2str(i), ' of ', num2str(numel(csvFiles)), ': ', csvFiles(i).name]);
end

% Remove all variables created by this script
clear inputSubdirectoryPath outputSubdirectoryPath csvFiles i fid fidOut line lines processedLines fileName outputFilePath updateTimer;