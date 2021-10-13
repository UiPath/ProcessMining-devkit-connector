# Connector & application framework

> Version 0.1
> Click to see the release notes

**TODO: add link to releaes notes of the framework**

The following framework describes the standardized format for storing connector and application templates for UiPath Process Mining. The framework gives grip on the way connectors and applications are created. The following artefacts are included:

- Repository structure
- Devkit connector
- Devkit documenation
- Enablement documentation
    - Setup the start of a connector
	- SQL documentation
	- Technical documentation
- [Automated testing & validation](Automated_testing_validation.md)
- Connector documentation template
- Archive of version

**TODO: make the items in the list clickable links when the subpages are setup.**

### Development process
Work pushed to the **main** branch will is fit to be released to customers. Work which is still in development, which should not yet reach customers, should be on other branches.

The significant milestones of the connector are marked in the repo as a **Release**, with corresponding **release notes**. This makes it easy for customers to checkout the latest release.

During development of the first version of a connector, there is no official release yet. It will be indicated clearly on the landing page of the connector.

### Versioning convention
This part will be changed in PA-1811. This is a copy from what is present on https://uipath.atlassian.net/wiki/spaces/DEV/pages/86602809452/WIP+Framework+for+Apps+Connectors. The proposed versioning is called semantic versioning.

Apps are versioned taking into account their data model. Minor numbers are used for incremental updates to the data model; major versions are used to define breaking changes to the data model.

Examples

Adding the Users entity to an app would allow more data to be passed to the app, but it’s not mandatory --> App1.1 to App1.2.

Changing the input format of the Requisition table from one table to a Header and item table would break compatibility → App1.1 to App2.0.

Connector versioning

Connector versions indicate which major version of the data model is implemented.

Examples

P2P-app-SAP-connector 1.0 implements the P2P-app 1.x data model. So it works with all versions of P2P 1.x. 

Also all P2P-app-SAP-connector 1.x work with any P2P-app 1.x.

P2P-app-SAP-connector 1.3 is not compatible with the P2P-app/2.0 or higher.
