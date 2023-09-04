select * from {{source('my_store', 'orders')}}
where total_price < 0
