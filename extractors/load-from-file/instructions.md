# Instructions
See for instructions about the `load-from-file` extraction method the UiPath documentation. 

## Configuration
Input files for this connector can be found in the `data.zip` in the sample_data folder. These are tab delimited .csv files. To load them using the `load-from-file` extraction method, make sure to extract the .zip and configure the source connection in CData Sync to point to the location of the files.

Use the following custom query when creating the job:
```
{
    REPLICATE [Change_log_raw] SELECT * FROM [Change_log];
    REPLICATE [Invoices_raw] SELECT * FROM [Invoices];
    REPLICATE [Purchase_order_approvals_raw] SELECT * FROM [Purchase_order_approvals];
    REPLICATE [Purchase_orders_raw] SELECT * FROM [Purchase_orders];
    REPLICATE [Purchase_orders_status_raw] SELECT * FROM [Purchase_orders_status];
    REPLICATE [Users_raw] SELECT * FROM [Users];
}
```

To run the extraction method, configure and execute the `extract_cdata.ps1` file that can be found in the scripts folder.
