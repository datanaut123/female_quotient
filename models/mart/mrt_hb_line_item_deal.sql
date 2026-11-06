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
    ),

    joined as (
        select
            a.line_item_id,
            a.amount,
            a.name,
            a.product_id,
            a.product_type,
            a.create_date,
            a.bundle_id,
            a.bundle_item_quantity,
            a.description,
            a.is_optional,
            a.is_parent,
            a.discount,
            a.price,
            a.primary_vs_add_on_bundles,
            a.product_family,
            a.quantity,
            a.tentpole_event_group,
            a.annual_contract_value,
            a.pre_discount_amount,
            a.deal_id,
            b.deal_name,
            b.deal_url,
            b.deal_create_date,
            b.date,
            b.quarter,
            b.pipeline_amount,
            b.deal_close_date,
            b.stage_name,
            b.owner_name,
            b.owner_email,
            b.company_name,
            b.deal_link,
            b.stage_ranking,
            b.deal_source_tentpole,
            b.opportunity_type,

            case
                when b.stage_name = '1% - Prospecting'
                then a.amount * 0.01
                when b.stage_name = '20% - Prelim Convo/Shared Overview'
                then a.amount * 0.20
                when b.stage_name = '40% - Sent RFP Response'
                then a.amount * 0.40
                when b.stage_name = '60% - Active Negotiation'
                then a.amount * 0.60
                when b.stage_name = '80% - Recommended/Likely to Close'
                then a.amount * 0.80
                else 0
            end as weighted_pipeline_amount,

            case
                when
                    b.stage_name in (
                        'Invoice: Paid',
                        'Closed Won',
                        '85% - Agreement: In Progress (Verbal)'
                    )
                then a.amount
                else 0
            end as booked_amount

        from cte_1 as a
        left join cte_2 as b on a.deal_id = b.deal_id
    ),

    tentpoles as (
        select distinct tentpole_event_group
        from joined
        where tentpole_event_group is not null
    ),

    bounds as (
        select
            date_trunc(min(date(create_date)), year) as start_date,
            date_add(
                date_trunc(max(date(create_date)), year), interval 5 year
            ) as end_date
        from joined
    ),

    spine as (
        select t.tentpole_event_group, d.date_day

        from {{ ref("stg_dates") }} as d
        cross join bounds as b
        cross join tentpoles as t
        where d.date_day >= b.start_date and d.date_day < b.end_date
    ),

    final as (
        select
            j.* replace (
                coalesce(
                    j.tentpole_event_group, s.tentpole_event_group
                ) as tentpole_event_group,
                coalesce(date(j.create_date), s.date_day) as create_date,
                coalesce(j.booked_amount, 0) as booked_amount,
                coalesce(j.weighted_pipeline_amount, 0) as weighted_pipeline_amount
            ),
            j.line_item_id is null as is_date_spine_row

        from joined as j
        full join
            spine as s
            on j.tentpole_event_group = s.tentpole_event_group
            and date(j.create_date) = s.date_day
    )

select
    *,
    sum(booked_amount) over (
        partition by tentpole_event_group, extract(year from create_date)
        order by create_date
        rows between unbounded preceding and current row
    ) as cumulative_booked_amount,

    sum(weighted_pipeline_amount) over (
        partition by tentpole_event_group, extract(year from create_date)
        order by create_date
        rows between unbounded preceding and current row
    ) as cumulative_pipeline_amount,

    sum(amount) over (
        partition by tentpole_event_group, extract(year from create_date)
        order by create_date
        rows between unbounded preceding and current row
    ) as cumulative_pipeline_amount_actual

from final









{# with
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
    coalesce(create_date,date_day) as create_date,
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
full join {{ref("stg_dates")}} as c on a.create_date = c.date_day #}
