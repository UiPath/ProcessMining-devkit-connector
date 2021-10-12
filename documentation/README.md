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
- Validation framework
- Connector documentation template
- Archive of version

**TODO: make the items in the list clickable links when the subpages are setup.**

### Development process
Work pushed to the **main** branch will is fit to be released to customers. Work which is still in development, which should not yet reach customers, should be on other branches.

The significant milestones of the connector are marked in the repo as a **Release**, with corresponding **release notes**. This makes it easy for customers to checkout the latest release.

During development of the first version of a connector, there is no official release yet. It will be indicated clearly on the landing page of the connector.

### Versioning convention
This part will be changed in PA-1811. This is a copy from what is present on https://uipath.atlassian.net/wiki/spaces/DEV/pages/86602809452/WIP+Framework+for+Apps+Connectors.

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

***

Introduction:
https://uipath.atlassian.net/wiki/spaces/DEV/pages/86602809452/WIP+Framework+for+Apps+Connectors

# setup starting environment (dbt, database, repo)
--> Setup starting environment for partner
TODO start working from the README file in the devkit repo
1. Go to https://github.com/UiPath-Process-Mining/devkit_connector
2. New repo --> 
	a. Do we make repo for partner?
	b. Can partner make repo? 
3. Rename connector to what partner is making
# introduction to process mining & what is a connector? & data models/architecture/
--> Process mining introduction
- TODO
--> Technical docs (data models):
- https://uipath.atlassian.net/wiki/spaces/DEV/pages/3476588113/Process+Mining+Data+Models
- connector_app_framework > Data_connector_design_spec.pdf
## technical connector/app documention
Probably we can refer to docs
--> Technical app documentation
https://uipath.atlassian.net/wiki/spaces/PG/pages/3130000219/P2P+Discovery+Accelerator+Input+Data

--> Technical app documentation
https://uipath.atlassian.net/wiki/spaces/PG/pages/3526464758/P2P+Discovery+Accelerator+table+structure

# Development
## Development guidelines: how to build connector
--> DevKit
We can maybe point to docs.
connector_app_framework > Devkit.pdf
## Development guidelines: SQL testing, tips & tricks - Birce 
--> SQL best practices & Learnings
https://uipath.atlassian.net/wiki/spaces/PG/pages/3591440028/SQL+connectors+learnings+and+best+practices

--> SQL testing
https://uipath.atlassian.net/wiki/spaces/PG/pages/3624114244/SQL+connectors+testing

--> SQL implementation tips & tricks
https://uipath.atlassian.net/wiki/spaces/PG/pages/84562968979/Implementation+details
## Documentation from partners
--> Documentation template
connector_app_framework > Connector_documentation_template.docx

# Validation & acceptance
-- Testing framework
https://uipath.atlassian.net/wiki/spaces/DEV/pages/84564934829/Cloud+connector+testing+framework
