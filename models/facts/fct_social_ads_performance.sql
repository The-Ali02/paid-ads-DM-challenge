{{ config(
   materialized="table"
) }}

with bing_metrics as (
    select 
        date,
        Ad_id,
        adset_id, 
        campaign_id,
        null as creative_id,
        channel,
        
       --metrics/facts
        clicks,
        impressions,
        revenue,
        spend,
        null as purchase,
        total_conversions,
        null as comments,
        null as likes,
        null as link_clicks,
        null as shares,
        null as views,
        null as ADD_TO_CART, 
        null as installs,
        null as registrations,
        null as ENGAGEMENTS,
        null as VIDEO_VIEWS,
        null as SKAN_APP_INSTALL,
        null as SKAN_CONVERSION

    from {{ ref('stg_bing_ads')}}
),
 facebook_metrics as (
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
        purchase_value as revenue,
        spend,
        purchase,
        purchase as total_conversions,
        comments,
        likes,
        link_clicks,
        shares,
        views,
        ADD_TO_CART, 
        installs,
        registrations,
        (likes+views+clicks+shares+comments) as ENGAGEMENTS,
        null as VIDEO_VIEWS,
        null as SKAN_APP_INSTALL,
        null as SKAN_CONVERSION

    from {{ ref('stg_facebook_ads') }}
),
tiktok_metrics as (
    select 
        date,
        Ad_id, 
        adset_id, 
        campaign_id,
        null as creative_id,
        channel,

        --metrics
        clicks,
        IMPRESSIONS,
        null as revenue,
        SPEND,
        purchase,
        total_conversions,
        null as comments,
        null as likes,
        null as link_clicks,
        null as shares,
        null as views,
        ADD_TO_CART, 
        installs,
        registrations,
        null as ENGAGEMENTS,
        VIDEO_VIEWS,
        SKAN_APP_INSTALL,
        SKAN_CONVERSION

    from {{ ref('stg_tiktok_ads') }}
),
twitter_metrics as (
    select 
        date,
        null as ad_id,
        null as adset_id,
        campaign_id,
        null as creative_id,
        channel,
        
        --metrics
        clicks,
        IMPRESSIONS,
        null as revenue,
        SPEND,
        null as purchase,
        null as total_conversions,
        comments,
        LIKES,
        link_clicks,
        retweets as shares, --mapping retweet action with shares on facebook, since they both are similar
        null as views,
        null as ADD_TO_CART, 
        null as installs,
        null as registrations,
        ENGAGEMENTS,
        VIDEO_VIEWS,
        null as SKAN_APP_INSTALL,
        null as SKAN_CONVERSION

    from {{ ref('stg_twitter_ads') }}
),
final as (
    select *
    from bing_metrics
    union all
    select *
    from facebook_metrics
    union all
    select *
    from tiktok_metrics
    union all
    select *
    from twitter_metrics
)

select *
from final
