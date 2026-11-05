with
    cte_1 as (
        select
            id,
            amount,
            name,
            product_id,
            product_type,
            create_date,
            bundle_id,
            bundle_item_quantity,
            description,
            is_optional,
            is_parent,
            discount,
            price,
            primary_vs_add_on_bundles,
            product_family,
            quantity,
            tentpole_event_group,
            annual_contract_value,
            pre_discount_amount

        from {{ ref("stg_hb_line_item") }}
    ),

    cte_2 as (select deal_id, line_item_id from {{ ref("stg_hb_line_item_deal") }})

select
    coalesce(id, line_item_id) as line_item_id,
    amount,
    name,
    product_id,
    product_type,
    create_date,
    bundle_id,
    bundle_item_quantity,
    description,
    is_optional,
    is_parent,
    discount,
    price,
    primary_vs_add_on_bundles,
    product_family,
    quantity,
    tentpole_event_group,
    annual_contract_value,
    pre_discount_amount,
    deal_id

from cte_1 as a
left join cte_2 as b on a.id = b.line_item_id
