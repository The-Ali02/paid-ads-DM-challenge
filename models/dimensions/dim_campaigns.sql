{{ config(
   materialized="table"
) }}
--Creting this as dimension, since even if we have a broader fields with information like campaing_name,
--campaign_start_date, campaign_end_date, campaign_type, is_active fields can be introduced here easily

with bing_campaign as (
    select 
        distinct campaign_id,
        channel,
        null as OBJECTIVE,
        null as BUYING_TYPE

    from {{ ref('stg_bing_ads')}}
),
 facebook_campaign as (
    select 
        distinct campaign_id,
        channel,
        OBJECTIVE,
        BUYING_TYPE
       
    from {{ ref('stg_facebook_ads') }}
),
tiktok_campaign as (
    select 
        distinct campaign_id,
        channel,
        null as OBJECTIVE,
        null as BUYING_TYPE
   
    from {{ ref('stg_tiktok_ads') }}
),
 twitter_campaign as (
    select 
        distinct campaign_id,
        channel,
        null as OBJECTIVE,
        null as BUYING_TYPE
       
    from {{ ref('stg_twitter_ads') }}
)

select *
from bing_campaign
union
select *
from facebook_campaign
union
select *
from tiktok_campaign
union
select *
from twitter_campaign
