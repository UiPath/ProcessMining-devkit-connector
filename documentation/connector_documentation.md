# \<Connector title>

\<Name of developing company>\
\<Developer name + email 1>\
\<Developmer name + email 2>\
\<...>

[REMOVE THIS: The intended audience of this documentation is a developer persona that intends to use/deploy this connector. Please keep this in mind when writing this documentation.]

## Table of contents
- [General solution description](#General-solution-description)
    - [Source system](#Source-system)
    - [Process](#Process)
    - [Connector output & compatability](#Connector-output-&-compatability)
- [Source system data](#Source-system-data)
    - [Data availability](#Data-availability)
    - [Data extraction & connection to source system](#Data-extraction-&-connection-to-source-system)
    - [Input data](#Input-data)
    - [Entities](#Entities)
    - [Activities](#Activities)
    - [Output attribute mapping](#Output-attribute-mapping)
- [Connector design flowchart](#Connector-design-flowchart)
- [Connector design details](#Connector-design-details)
- [How to extend the connector](#How-to-extend-the-connector)
    - [Connector configuration](#Connector-configuration)
    - [Adding output attributes](#Adding-output-attributes)
    - [Adding activities](#Adding-activities)
    - [Adding entities](#Adding-entities)
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

### Connector output & compatability
\<Refer to the data model and corresponding Process Mining application that this connector is compatible with and built for.>

## Source system data
### Data availability
\<Many systems require certain options to be turned on for the system to start generating proper logs. Describe what is required on the source system side to use this connector. For example, should certain tables be used? Should certain fields be used in a specific way?>

### Data extraction & connection to source system
\<Describe in detail the different ways in which data could/should be extracted from the source system.>

### Input data
\<List and describe each of the input tables required by the connector.>\
\<For each input table, list and describe the fields to be extracted.>\
\<List fields that can be used to filter input data.>

### Entities
\<If the connector output contains entities: for each entity, list which input data is used to create an entity.>

### Activities
\<For each activity, list which input data is used to create an activity. Also, provide a brief description of each activity and its relevance.>

### Output attribute mapping
\<For each output attribute, list which input data is used to create an attribute and briefly describe how the attribute values are computed. Also, for any attribute that is not part of the data model for which this connector is created, describe the attribute and its relevance.>

## Connector design flowchart
\<Connector design flowchart that visually shows on a high level how the data 'flows' through the connector. At least include input and output tables.> 

## Connector design details
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

## Limitations, known issues, common problems
### Limitations
\<List all known limitations.>

### Known issues
\<List all known limitations.>

### Common problems
\<List common problems and how to tackle them.>\
\<For example, if an input field is missing, is there a different place where it could be found?>
