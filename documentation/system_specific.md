# \<Connector title>

[REMOVE THIS: The intended audience of this documentation is a developer persona that intends to use/deploy this connector. Please keep this in mind when writing this documentation.]

## Table of contents
- [Prerequisites](#Prerequisites)
    - [Source system](#Source-system)
    - [Environmental settings](#Environmental-settings)
    - [System specific settings](#System-specific-settings)
- [Extraction](#Extraction)
    - [Data extraction & connection to source system](#Data-extraction--connection-to-source-system)
    - [Input data](#Input-data)
- [Connector configuration](#Connector-configuration)
- [Connector transformation design](#Connector-transformation-design)
    - [Entities](#Entities)
    - [Activities](#Activities)
    - [Fields](#Fields)
    - [Design flowchart](#Design-flowchart)
    - [Design details](#Design-details)
- [How to extend the connector](#How-to-extend-the-connector)
    - [Adding fields](#Adding-fields)
    - [Adding activities](#Adding-activities)
- [Limitations, known issues, common problems](#Limitations-known-issues-common-problems)
    - [Limitations](#Limitations)
    - [Known issues](#Known-issues)
    - [Common problems](#Common-problems)

## Prerequisites
\<Overview of all prerequisites to be met.>

### Source system
\<Describe the source system for which this connector was built. Include technical details such as version compatibility.>

### Environmental settings
\<Description of any environmental prerequisites, like server requirements and configuration needed in firewall to be able to use the extractor or connector.>

### System specific settings
\<Overview of all specific settings to be configured, additional modules to be installed, special access to be granted or specific ways to make use of the source system to start generating proper logs.

## Extraction

### Data extraction & connection to source system
\<Only refer to the detailed documentation provided in the `extractor` folder for each extraction method.>

### Input data
\<List and describe each of the input tables required by the connector.>\
\<For each input table, list and describe the fields to be extracted.>\
\<For each field, list the name, description, and data type.>\
\<List fields that can be used to filter input data.>

## Connector configuration
\<Describe which configuration options the connector provides out of the box. Describe where and how these settings should be defined.>

## Connector transformation design

### Entities
\<If the connector transformations output contains entities: for each entity, list which input data is used to create an entity.>

### Activities
\<For each activity, list which input data is used to create an activity. Also, provide a brief description of each activity and its relevance.>

### Fields
\<Describe the available fields for entities and events, list which input data is used to create the field and briefly describe how the field values are computed. Also, for any field that is not part of the data model for which this connector is created, describe the field and its relevance.>

### Design flowchart
\<Connector design flowchart that visually shows on a high level how the data 'flows' through the connector.>

### Design details
\<List and describe any relevant design details not yet covered in the other sections. If none exist, remove this section.>

## How to extend the connector

### Adding fields
\<Describe steps that are specific to this connector when adding fields.>

### Adding activities
\<Describe steps that are specific to this connector when adding activities.>

## Limitations, known issues, common problems

### Limitations
\<List all known limitations.>

### Known issues
\<List all known issues.>

### Common problems
\<List common problems and how to tackle them.>\
\<For example, if an input field is missing, is there a different place where it could be found?>
