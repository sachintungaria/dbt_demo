{{
    config(
        materialized='incremental',
        unique_key='order_id',
        incremental_strategy='merge'
    )
}}

select
    order_id,
        customer_id,
        product_id,
        quantity,
    '09-09-2026' as updated_at
from {{ source('raw', 'raw_orders') }}

{% if is_incremental() %}

where update_at >= (
    select coalesce(dateadd(day, -2, max(updated_at)),
        '1900-01-01'::timestamp)
        from {{ this }}
)

{% endif %}