# dbt Portable Google Sheets Transformer

## Introduction

This dbt macro is designed to transform data written by the Portable (portable.io) Google Sheets connector. Portable writes data in JSON format, and this macro efficiently converts it back into standard columns and rows. This is particularly useful for dbt users who need to integrate Google Sheets data into their analytical workflows.

## Installation

To use this macro in your dbt project, add the following to your `packages.yml` file:

```yaml
packages:
  - git: "https://github.com/[your-github-username]/dbt-portable-google-sheets-transformer.git"
    revision: [latest-release-tag]
```

Run `dbt deps` to install the package.

## Usage


In an empty .sql file (dbt model), call the macro:

``````

{{ portable_google_sheets( 'google_sheets', 'sample_data', include_metadata=True, keep_sort=False ) }}
``````
### Parameters
- source_name: Name of the source.
- source_table: Name of the table within the source.
- include_metadata: Boolean flag to include metadata columns. Optional. Default is True.
- keep_sort: Boolean flag to maintain sort order. Default is False.

# Macro Details
The portable_google_sheets macro performs the following operations:

1. Extracts column names from the JSON data.
1. Transforms JSON data into rows and columns.
1. Handles potential column name conflicts (like "ID").
1. Optionally includes metadata and sorts data based on the _PORTABLE_ID.

Refer to the macro code for detailed implementation.

# Contributing
Contributions to this macro are welcome! To contribute:

Fork the repository.
Create a new branch for your feature or bug fix.
Make changes and test your code.
Submit a pull request with a clear description of the changes.
