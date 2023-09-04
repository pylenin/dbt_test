{{config(materialized="incremental")}}


select * from {{source('my_store', 'orders')}}
{% if is_incremental() %}

  where ORDER_DATE > (select max(ORDER_DATE) from {{ this }})

{% endif %}
