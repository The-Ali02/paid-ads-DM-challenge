{{ config(materialized="table") }}

--here we exclude various platform specific metrics that are not required for our reporting dashboard
with reporting as (
    select 
        date,
        Ad_id,
        adset_id, 
        campaign_id,
        creative_id,
        channel,
        
        --metrics
        clicks,
        impressions,
        revenue,
        spend,
        purchase,
        total_conversions,
        comments,
        likes,
        link_clicks,
        shares,
        views,
        ADD_TO_CART, 
        installs,
        registrations,
        ENGAGEMENTS,
        VIDEO_VIEWS

    from {{ ref('fct_social_ads_performance') }}
)
select  *
from reporting
