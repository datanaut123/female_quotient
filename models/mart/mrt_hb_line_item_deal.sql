with
    cte_1 as (
        select
            line_item_id,
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

        from {{ ref("fct_hb_line_item_deal") }}
    ),

    cte_2 as (
        select
            deal_id,
            deal_name,
            deal_url,
            deal_create_date,
            date,
            quarter,
            pipeline_amount,
            deal_close_date,
            stage_name,
            owner_name,
            owner_email,
            company_name,
            deal_link,
            stage_ranking,
            deal_source_tentpole,
            opportunity_type

        from {{ ref("mrt_hb_deals") }}
    )

select
    line_item_id,
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
    coalesce(a.deal_id, b.deal_id) as deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    date,
    quarter,
    pipeline_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link,
    stage_ranking,
    deal_source_tentpole,
    opportunity_type,
    case
        when stage_name = '1% - Prospecting'
        then amount * 0.01
        when stage_name = '20% - Prelim Convo/Shared Overview'
        then amount * 0.20
        when stage_name = '40% - Sent RFP Response'
        then amount * 0.40
        when stage_name = '60% - Active Negotiation'
        then amount * 0.60
        when stage_name = '80% - Recommended/Likely to Close'
        then amount * 0.80
        else 0
    end as weighted_pipeline_amount,

    case
        when
            stage_name
            in ('Invoice: Paid', 'Closed Won', '85% - Agreement: In Progress (Verbal)')
        then amount
        else 0
    end as booked_amount

from cte_1 as a
left join cte_2 as b on a.deal_id = b.deal_id
