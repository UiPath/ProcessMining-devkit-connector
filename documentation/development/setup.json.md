
# A set of settings for this connector:

- **name**: display name of the connector.
- **app**: a reference to the repo name of the implemented app.
- **framework-version**: the version of the Connector and App framework that was used to create this connector.

The framework will use major numbers for breaking changes, minor numbers for incremental non-breaking changes. Doing this is needed to make sure we know which connector/app definition is readible by our software, and which connectors/apps we still support.

- **extractor**: current extraction method that’s used to extract data. This setting is left empty for connector templates.

Example:

```json
{
  "name": "SAP connector for Purchase-to-Pay Discovery Accelerator",
  "app": "P2P-app",
  "framework-version": "1.0",
  "extractor": "load-from-file"
}
```
