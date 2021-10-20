# Deliverables
A newly developed connector is expected to have the same repository structure as the devkit connector. This document describes what the repository should contain for a released connector.

## .vscode\
Workspace settings that are relevant when working in Visual Studio Code. The folder contains an `extensions.json` and a `settings.json` file. The `extensions.json` lists recommended extensions to support development on the connector. The `settings.json` contains settings related to formatting. The content of this folder could remain the same as in the devkit connector.

## documentation\
The documentation folder should contain relevant documentation to the developed connector. The [connector_documentation.docx](connector_documentation.docx) is the template to provide this documentation. In addition, diagrams or other supporting information can be provided.

The documentation that is available in the devkit connector can to a large extent remain since it is relevant for connectors in general. Only the documentation in the enablement folder should be cleaned up before a release.

## extractors\
Contains the instructions on using the extraction method to extract data for the. The extraction method that is currently used is CData.

The extractor should contain instructions about:
- **Installation**: how to set up the extractor.
- **Configuration**: configuration on using the extraction method such that the required data is in place for the transformations.

## sample_data\
A sample dataset to validate the transformations and which and can serve as an example for customers using the connector for the first time. The data should be in the form of .csv files.

Quality requirements:
- All defined activities should be present on the output dataset.
- All mandatory fields should contain values for the complete output dataset.
- All optional fields should at least contain values for some cases in the output dataset.
- The data should be an extraction from the source system. This does not have to be real data, but can be artificially created in the system.
- In case real data is used, the data should be anonimized.

Size requirements:
- The data size should be less than 1MB.
- Minimum data size is not defined. For example, if 5 cases can fullfill the quality requirements than that is sufficient.

Besides the small sample dataset, a large dataset will be requested to check the performance of the transformations. This dataset will be stored outside the git repository.

## scripts\
Scripts are provided to extract data and to run transformations and tests.

## transformations\
The dbt project in this folder defines all transformations from input data to the data model of the app. The transformations are writtin according to the guidelines as described in [development_best_practices.md](..\development_best_practices.md). 

## .gitignore
Generated files from running the transformations are listed. The content of this folder could remain the same as in the devkit connector.

## README.md
This section describes instructions on how to use the connector. 

## license.txt
License for UiPath Process Mining connectors. This license is the same as the one available in the devkit connector.

## settings.json
Settings for this connector:

- **name**: display name of the connector.
- **app**: a reference to the repository of the implemented app.
- **framework-version**: the version of the Connector and App framework that was used to create this connector.
- **extractor**: extraction method that is used to extract data. 

Example:

```json
{
  "name": "SAP connector for Purchase-to-Pay Discovery Accelerator",
  "app": "P2P-app",
  "framework-version": "1.0",
  "extractor": "CData"
}
```
