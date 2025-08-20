{{ config(
   materialized="table"
) }}

with stg_tiktok_ads as (
    select 
        date,
        cast(ad_id as string) as ad_id,
        cast(ADGROUP_ID as string)           as adset_id,
        cast(campaign_id as string)          as campaign_id,
        AD_STATUS,
        AD_TEXT,
        channel,  -- or hardcode as 'facebook'

        -- performance metrics
        clicks,
        IMPRESSIONS,
        SPEND,

        -- engagement metrics
        ADD_TO_CART,
        VIDEO_VIEWS,

        --conversion metrics 
        RT_INSTALLS as installs,
        SKAN_APP_INSTALL,
        PURCHASE,
        REGISTRATIONS,
        CONVERSIONS as total_conversions,
        SKAN_CONVERSION

    from {{ ref('src_ads_tiktok_ads_all_data') }}
)
select *
from stg_tiktok_ads