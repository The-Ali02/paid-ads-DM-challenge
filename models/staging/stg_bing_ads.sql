{{ config(
   materialized="table"
) }}

with stg_bing_ads as (
    select 
        date,
        cast(ad_id as string) as ad_id,
        cast(adset_id as string) as adset_id,
        cast(campaign_id as string) as campaign_id,
        channel,
        ad_description,
        title_part_1 as title_p1,
        title_part_2 as title_p2,
        clicks,
        imps as impressions,
        revenue,
        spend,
        conv as total_conversions        
    from {{ ref('src_ads_bing_all_data')}}
)
select *
from stg_bing_ads