# \<Connector title>

[REMOVE THIS: The intended audience of this documentation is a developer persona that intends to use/deploy this connector. Please keep this in mind when writing this documentation.]

## Table of contents
- [General solution description](#General-solution-description)
    - [Source system](#Source-system)
    - [Process](#Process)
    - [Connector output & compatability](#Connector-output-&-compatability)
- [Prerequisites](#Prerequisites)
    - [Environmental settings](#Environmental_settings)
    - [System specific settings](#System_specific_settings)
- [Extraction](#Extraction)
    - [Data extraction & connection to source system](#Data-extraction-&-connection-to-source-system)
    - [Input data](#Input-data)
- [Connector transformation design](#Connector_transformation_design)
    - [Entities](#Entities)
    - [Activities](#Activities)
    - [Output attribute mapping](#Output-attribute-mapping)
    - [Business data configuration](#Business_data_configuration)
    - [KPIs](#KPIs)
- [Connector transformation design diagrams](#Connector_transformation_design_diagrams)
    - [Connector transformation design flowchart](#Connector-transformation-design-flowchart)
    - [Entity relationship diagram](#Entity_relationship_diagram)
- [Connector transformation design details](#Connector-transformation-design-details)
- [How to extend the connector](#How-to-extend-the-connector)
    - [Connector configuration](#Connector-configuration)
    - [Adding output attributes](#Adding-output-attributes)
    - [Adding activities](#Adding-activities)
    - [Adding entities](#Adding-entities)
    - [Adding business data](#Adding_business_data)
- [Limitations, known issues, common problems](#Limitations-known-issues-common-problems)
    - [Limitations](#Limitations)
    - [Known issues](#Known-issues)
    - [Common problems](#Common-problems)

## General solution description
\<High level solution description>

### Source system
\<Describe the source system for which this connector was built. Include technical details such as version compatibility.>

### Process
\<High level description of the process for which this connector was built. >

### Connector output & compatibility
\<Refer to the data model and corresponding Process Mining application that this connector is compatible with and built for.>

## Prerequisites
\<Overview of all prerequisites to be met.>

### Environmental settings
\<Description of any environmental prerequisites, like server requirements and configuration needed in firewall to be able to use the extractor or connector.>

### System specific settings
\<Overview of all specific settings to be configured, additional modules to be installed, special access to be granted or specific ways to make use of the source system to start generating proper logs.

## Extraction

### Data extraction & connection to source system
\<Describe in detail the different data extractors provided. Describe how to setup each extractor, which settings are available and how to connect to the source system. Also provide information how the different scripts provided should be used.>

### Input data
\<List and describe each of the input tables required by the connector.>\
\<For each input table, list and describe the fields to be extracted.>\
\<List fields that can be used to filter input data.>

## Connector transformation design

### Entities
\<If the connector transformations output contains entities: for each entity, list which input data is used to create an entity.>

### Activities
\<For each activity, list which input data is used to create an activity. Also, provide a brief description of each activity and its relevance.>

### Output attribute mapping
\<For each output attribute, list which input data is used to create an attribute and briefly describe how the attribute values are computed. Also, for any attribute that is not part of the data model for which this connector is created, describe the attribute and its relevance.>

### Business data configuration
\<In case the connector is created to output data for TemplateOne, give an overview how the input for the business data has to be configured (tags, due dates) and a definition of tags and due dates which are available out of the box.>

### KPIs
\<This section is only needed for TemplateOne connectors. List the KPIs that can be calculated based on the data that is provided for TemplateOne. Also provide the related definition.>

| KPI | Description |
| :---: | :---: |
| Automation rate| (Number of events where Automated equals `TRUE` / Total number of events) |

\<Add a disclaimer: Not all KPIs are available in TemplateOne out of the box, they might have to be added to app.>

## Connector transformation design diagrams

### Connector transformation design flowchart
\<Connector design flowchart that visually shows on a high level how the data 'flows' through the connector. At least include input and output tables.> 

### Entity relationship diagram
\<In case multiple entities are used and combined in the output give an entity relationship diagram.>

## Connector transformation design details
\<List and describe any relevant design details not yet covered in the other sections. If none exist, remove this section.>

## How to extend the connector
### Connector configuration
\<Describe which configuration options the connector provides out of the box. Describe where and how these settings should be defined.>

### Adding output attributes
\<Describe how to add output attributes to the connector.>

### Adding activities
\<Describe how to add activities to the connector.>

### Adding entities
\<Describe how to add entities to the connector.>

### Adding business data
\<Describe how to add business data (tags, due dates) to the connector. This section is only applicable if the connector outputs files for TemplateOne.>

## Limitations, known issues, common problems
### Limitations
\<List all known limitations.>

### Known issues
\<List all known issues.>

### Common problems
\<List common problems and how to tackle them.>\
\<For example, if an input field is missing, is there a different place where it could be found?>
