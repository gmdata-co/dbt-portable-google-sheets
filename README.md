# dbt Portable Google Sheets Transformer

## Introduction

This dbt macro is designed to transform data written by the Portable (portable.io) Google Sheets connector. Portable writes data in JSON format, and this macro efficiently converts it back into standard columns and rows. This is particularly useful for dbt users who need to integrate Google Sheets data into their analytical workflows.

## Installation

To use this macro in your dbt project, add the following to your `packages.yml` file:

```yaml
packages:
  - git: "https://github.com/gmdata-co/dbt-portable-google-sheets-transformer.git"
    revision: 0.1.0
```

Run `dbt deps` to install the package.

## Usage


In an empty .sql file (dbt model), call the macro:

``````

{{ portable_google_sheets( 'google_sheets', 'sample_data', include_metadata=True, keep_sort=False ) }}
``````
### Parameters

- **`source_name`**: 
  - **Description**: Name of the source in sources.yml.
  - **Type**: String
  - **Required**

- **`source_table`**:
  - **Description**: Name of the table within the source.
  - **Type**: String
  - **Required**

- **`include_metadata`**:
  - **Description**: Boolean flag to include Portable's metadata columns:
    - `_portable id`: we rename Portable's `id` to `_portable_id` so it does not conflict with any `id` column in your source data.
    - `_portable_extracted`: column shows as-is.
  - **Type**: Boolean
  - **Optional**
  - **Default**: `True`

- **`keep_sort`**:
  - **Description**: Boolean flag to maintain sort order.
  - **Type**: Boolean
  - **Optional**
  - **Default**: `False`

## Assumptions
This macro assumes that your data in google sheets looks like data.  That is to say it is organized in columns and rows and has headers.

We will release an update shortly to handle data with no headers.

## Macro Details
The portable_google_sheets macro performs the following operations:

1. Extracts column names from the JSON data.
1. Transforms JSON data into rows and columns.
1. Handles potential column name conflicts (like "ID").
1. Optionally includes metadata and sorts data based on the _PORTABLE_ID.

Refer to the macro code for detailed implementation.

## Contributing
Contributions to this macro are welcome! To contribute:

Fork the repository.
Create a new branch for your feature or bug fix.
Make changes and test your code.
Submit a pull request with a clear description of the changes.

## Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
