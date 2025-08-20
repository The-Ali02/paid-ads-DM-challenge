{{ config(
   materialized="table"
) }}

with stg_facebook_ads as (
    select 
        date,
        cast(ad_id as string)                as ad_id,
        cast(adset_id as string)             as adset_id,
        cast(campaign_id as string)          as campaign_id,
        cast(creative_id as string)          as creative_id,
        CREATIVE_TITLE,
        OBJECTIVE, --CONVERSIONS,OUTCOME_SALES,OUTCOME_AWARENESS,LINK_CLICKS
        BUYING_TYPE,
        CAMPAIGN_TYPE,
        CREATIVE_BODY,
        channel,  -- or hardcode as 'facebook'

        -- performance metrics
        clicks,
        INLINE_LINK_CLICKS as link_clicks,
        impressions,
        spend,

        -- engagement metrics
        likes,
        comments,
        shares,
        VIEWS,

        --conversion metrics 
        ADD_TO_CART, --not sure if this needs to be in conversion or engagement?
        MOBILE_APP_INSTALL as installs,
        PURCHASE,
        COMPLETE_REGISTRATION as registrations,

        --revenue calc
        PURCHASE_VALUE   --revenue in dollars generated via purchases

    from {{ ref('src_ads_creative_facebook_all_data') }}
)
select *
from stg_facebook_ads