{{ config(
   materialized="table"
) }}
--Creting this as dimension, since even if we have a broader fields with information like
--adset_name, adset_target, etc
with bing_adsets as (
    select 
        distinct adset_id,
        campaign_id      
    from {{ ref('stg_bing_ads')}}
),
 facebook_adsets as (
    select 
        distinct adset_id,
        campaign_id
       
    from {{ ref('stg_facebook_ads') }}
),
tiktok_adsets as (
    select 
        distinct adset_id,
        campaign_id
   
    from {{ ref('stg_tiktok_ads') }}
)
--twitter doesn't have adset level information
select *
from bing_adsets
union
select *
from facebook_adsets
union
select *
from tiktok_adsets
