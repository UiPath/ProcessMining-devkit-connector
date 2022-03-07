# \<Connector title>

[REMOVE THIS: The intended audience of this documentation is a developer persona that intends to use/deploy this connector. Please keep this in mind when writing this documentation.]

## Table of contents
- [General solution description](#General-solution-description)
    - [Process](#Process)
- [Connector transformation design](#Connector_transformation_design)
    - [Business data configuration](#Business_data_configuration)
    - [KPIs](#KPIs)
    - [Entity relationship diagram](#Entity_relationship_diagram)

## General solution description
\<High level solution description.>

### Process
\<High level description of the process for which this connector was built. >

### Business data configuration
\<In case the connector is created to output data for TemplateOne, give an overview how the input for the business data has to be configured (tags, due dates) and a definition of tags and due dates which are available out of the box.>

## Connector transformation design

### KPIs
\<This section is only needed for TemplateOne connectors. List the KPIs that can be calculated based on the data that is provided for TemplateOne. Also provide the related definition.>

| KPI | Description |
| :---: | :---: |
| Automation rate| (Number of events where Automated equals `TRUE` / Total number of events) |

\<Add a disclaimer: Not all KPIs are available in TemplateOne out of the box, they might have to be added to app.>

### Entity relationship diagram
\<In case multiple entities are used and combined in the output give an entity relationship diagram.>
