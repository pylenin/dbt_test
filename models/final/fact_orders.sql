select {{date_transformation('o.ORDER_DATE')}} as order_date,
    {{ dbt_utils.generate_surrogate_key(['o.ORDER_ID']) }} as order_id,
    o.QUANTITY,
    c.AGE,
    c.IS_USER_GUEST,
    c.FIRST_NAME,
    c.PHONE,
    c.EMAIL,
    c.LAST_NAME,
    o.ZIP_CODE,
    o.PRODUCT_ID,
    o.TOTAL_PRICE,
    o.ADDRESS_LINE,
    p.PRICE_PER_UNIT,
    p.PRODUCT_NAME,
    p.TOTAL_INVENTORY,
    p.PRODUCT_DESCRIPTION,
    promo.DISCOUNT_PERCENTAGE,
    promo.PROMO_CODE,
    {{date_transformation('promo.END_DATE')}} AS PROMO_END,
    {{date_transformation('promo.START_DATE')}} AS PROMO_START,
    '{{var("store_name")}}' as store_name,
    p.price_per_unit * o.quantity as theoretical_price
from {{ref('orders')}} o 
left join  {{ref('customers')}} c 
on o.customer_id = c.customer_id
left join {{ref('products')}} p 
on o.product_id = p.product_id
left join {{ref('promotions')}} promo 
on o.PROMO_CODE = promo.promo_code