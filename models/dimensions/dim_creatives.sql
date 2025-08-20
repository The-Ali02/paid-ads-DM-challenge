{{ config(
   materialized="table"
) }}

with facebook_creatives as (
    select 
        distinct creative_id,
        Ad_id,
        channel,
        CREATIVE_TITLE,
        CREATIVE_BODY,
        
    from {{ ref('stg_facebook_ads') }}
)

select *
from facebook_creatives