{{ config(
   materialized="table"
) }}

with stg_twitter_ads as (
    select 
        date,
        cast(campaign_id as string) as campaign_id,
        URL,
        TEXT,
        channel,  

        -- performance metrics
        clicks,
        IMPRESSIONS,
        SPEND,

        -- engagement metrics
        VIDEO_TOTAL_VIEWS as VIDEO_VIEWS,
        COMMENTS,
        ENGAGEMENTS,
        LIKES,
        URL_CLICKS as link_clicks,
        RETWEETS
        
    from {{ ref('src_promoted_tweets_twitter_all_data') }}
)
select *
from stg_twitter_ads