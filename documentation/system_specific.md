## General system description
\<High level system description.>

### Source system
\<Describe the source system for which this connector was built. Include technical details such as version compatibility.>

## Prerequisites
\<Overview of all prerequisites to be met.>

### Environmental settings
\<Description of any environmental prerequisites, like server requirements and configuration needed in firewall to be able to use the extractor or connector.>

### System specific settings
\<Overview of all specific settings to be configured, additional modules to be installed, special access to be granted or specific ways to make use of the source system to start generating proper logs.

## Extraction

### Data extraction & connection to source system
\<Refer to the documentation provided in the `extractor` folder for each extraction method. Same information provided in this folder should not be repeated. Also provide information how the different scripts provided should be used. >

### Input data
\<List and describe each of the input tables required by the connector.>\
\<For each input table, list and describe the fields to be extracted.>\
\<List fields that can be used to filter input data.>

## Connector configuration
\<Describe which configuration options the connector provides out of the box. Describe where and how these settings should be defined.>

## Connector transformation design

### Entities
\<If the connector transformations output contains entities: for each entity, list which input data is used to create an entity.>

### Activities
\<For each activity, list which input data is used to create an activity. Also, provide a brief description of each activity and its relevance.>

### Output attribute mapping
\<For each output attribute, list which input data is used to create an attribute and briefly describe how the attribute values are computed. Also, for any attribute that is not part of the data model for which this connector is created, describe the attribute and its relevance.>

### Connector transformation design flowchart
\<Connector design flowchart that visually shows on a high level how the data 'flows' through the connector. At least include input and output tables.> 

## How to extend the connector
### Adding output attributes
\<Describe how to add output attributes to the connector.>

### Adding activities
\<Describe how to add activities to the connector.>

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
