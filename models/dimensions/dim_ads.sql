{{ config(
   materialized="table"
) }}

with bing_ads as (
    select 
        distinct Ad_id,
        adset_id, 
        campaign_id,
        channel,
        ad_description as AD_TEXT,
        title_p1 as ad_title1,
        title_p2  as ad_title2 
    from {{ ref('stg_bing_ads')}}
),
 facebook_ads as (
    select 
        distinct Ad_id,
        adset_id, 
        campaign_id,
        channel,
        null as AD_TEXT,
        null as ad_title1,
        null as ad_title2
       
    from {{ ref('stg_facebook_ads') }}
),
tiktok_ads as (
    select 
        distinct Ad_id, 
        adset_id, 
        campaign_id,
        channel,
        AD_TEXT,
        null as ad_title1,
        null as ad_title2

    from {{ ref('stg_tiktok_ads') }}
),
twitter_ads as (
    select 
        distinct null as ad_id,
        null as adset_id,
        campaign_id,
        channel,
        text as AD_TEXT,
        null as ad_title1,
        null as ad_title2

    from {{ ref('stg_twitter_ads') }}
)
select *
from bing_ads
union
select *
from facebook_ads
union
select *
from tiktok_ads
union 
select *
from twitter_ads
