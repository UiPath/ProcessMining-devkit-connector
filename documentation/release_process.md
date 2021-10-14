# Release process

## Workflow
The main branch should be stable enough that it is possible to release. That means that the connector should only contain transformations without SQL errors and failing tests. Separate development branches should be created to develop on new functionality. 

The significant milestones of the connector are marked in the repository as a release. Each release has a version number that adheres to the described versioning below. Release notes are included that describe all changes that were made with respect to the previous version. 

Connectors that are in development and do not have a first release yet will not have any releases available on github. If there are restrictions on using a release, this will be clearly stated in the readme.

## Versioning
A version of an app has a corresponding data model. A connector transforms data that is compatible with an app. For this reason, apps with their corresponding data model are leading in the version numbering. Connector versions indicate which major version of the data model is implemented.

Semantic versioning is used to keep track of the different versions of connectors and apps. The version numbers are indicated by X.Y.Z and are updated according to the following guidelines:
- Z is updated for bug fixes that have no impact on the data model.
- Y is updated for new functionality that is compatible with the data model.
- X is updated when changes break the compatibility with the data model.

Significant milestones of apps and connectors result in a new release.

### Apps
Apps are versioned by taking into account the data model. The following examples describe how the version number should be updated:
- The metric to compute the total ordered value used the attribute requested value instead of ordered value. This resulted in incorrect numbers to be displayed. The correct attribute is now used in the app.
    - Update Z: App 1.0.0 → App 1.0.1
- The user entity is added to the app. The app has new content based on the newly added user entity. Having data for the user entity is not mandatory to use the app.
    - Update Y: App 1.0.1 → App 1.1.0
- The data model contains a requisition table. An update to the data model splits this table in requisition headers and requisition items. Having the requisition table in your data is not compatible anymore with the app.
    - Update X: App 1.1.0 → App 2.0.0

### Connectors
Connectors 1.x.x are compatible with App 1.x.x, which are all apps with major version 1. Connectors 1.x.x are not compatible with App 2.x.x, because a breaking change is introduced in the app. It is not possible that a connector has a higher major number than the corresponding app. 

The following examples describe how the version number should be updated:
- The ordered value attribute is based on the data source attribute for requested value. The correct data source attribute is now used in the connector.
    - Update Z: Connector 1.0.0 → Connector 1.0.1
- The connector transforms the data to the user entity such that newly available dashboards in the app can be used. This was not a mandatory entity.
    - Update Y: Connector 1.0.1 → Connector 1.1.0
- The connector transforms the requisition data to two separate tables: from requisitions to requisition headers and requisition items. By this change the new app can be used with this connector.
    - Update X: Connector 1.1.0 → Connector 2.0.0
