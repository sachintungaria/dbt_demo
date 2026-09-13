select
    c_customer_sk,
    c_customer_id,
    c_first_name,
    c_last_name,
    c_email_address
from {{ source('tpcds', 'customer') }}