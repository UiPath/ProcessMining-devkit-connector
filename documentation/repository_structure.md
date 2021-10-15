# Repository structure
A newly developed connector is expected to have the same repository structure as this devkit connector. This document describes what the repository should contain for a released connector. 
## .vscode
Workspace settings that are relevant when working in Visual Studio Code. The folder contains an `extensions.json` and a `settings.json` file. The `extensions.json` lists recommended extensions to support development on the connector. The `settings.json` contains settings related to formatting. The content of this folder could remain the same as the devkit connector. 
## documentation
supporting documentation about this connector.
## extractors
the extraction methods to load input data.
## sample_data
A sample dataset which is meaningful and comprehensive to validate the complete set of transformations in the connector. The data should be in the form of .csv files.

Quality requirements:
- All defined activities should appear and be recognized on the output dataset.
- All mandatory fields should be filled in for the complete output dataset.
- All optional fields should at least contain data for some cases in the output dataset.
- The data should be an extraction from the source system instead of artificially created data, since we expect the data stories to be present to run the validation (by following the data confidentiality guidelines).

Size requirements:
- The data size should be less than 1MB.
- We care about the expressiveness and relevance of the data rather than the actual size of it. Therefore, minimum data size will not be declared.

Besides the small sample dataset, a large dataset will be requested to check the performance of the transformations. 
## scripts
scripts to extract data, run transformations, and run tests.
## transforms
the transformations of the connector.
## .gitignore
generated files from running the transformations.
## README
 instructions on how to use the connector.
## license.txt
 license for UiPath Process Mining connectors.
## settings.json
 settings for this connector.
