-- original Redshift query

-- EXPLAIN
WITH
collection_total_views AS (
-- Query for dataframe collectionViewsSummaryNumbersDataframe(df_463d464d90bedc61180eda1933142c8e)
WITH
collection_info_raw AS (
SELECT DISTINCT
  collection_id,
  collection_display_name
FROM agent_insights_lt.agent_insights__collection_display_name
WHERE
  compass_user_id = '51269f59e94b802afbb93f48'
  AND (NULL IS NULL OR collection_id=NULL)

),
query_df_463d464d90bedc61180eda1933142c8e AS (
WITH
  periods AS (
    SELECT
      true AS is_current_period,
      '2020-11-09'::date AS start_date,
      '2020-11-15'::date AS end_date
    UNION ALL
    SELECT
      false AS is_current_period,
      '2020-11-09'::date +
        INTERVAL'1 day'*('2020-11-09'::date-'2020-11-15'::date-1)
      AS start_date,
      '2020-11-15'::date +
        INTERVAL'1 day'*('2020-11-09'::date-'2020-11-15'::date-1)
      AS end_date
  ),
  compass_views AS (
    SELECT
      cv.collection_id,
      cv.date,
      cv.new_user_page_views,
      cv.returning_user_page_views,
      cv.new_user_total_time_on_page,
      cv.returning_user_total_time_on_page,
      cv.page_views,
      cv.total_time_on_page,
      cv.page_views_for_avg_time
    FROM collection_info_raw
      JOIN agent_insights_lt.agent_insights__collection_views AS cv
        ON collection_info_raw.collection_id=cv.collection_id
  ),
  views_by_period AS (
    SELECT
      is_current_period,
      start_date,
      end_date,
      coalesce(sum(new_user_page_views),0) AS new_user_page_views,
      coalesce(sum(returning_user_page_views),0) AS returning_user_page_views,
      coalesce(sum(new_user_total_time_on_page),0) AS new_user_total_time_on_page,
      coalesce(sum(returning_user_total_time_on_page),0) AS returning_user_total_time_on_page,
      coalesce(sum(page_views),0) AS page_views,
      coalesce(sum(total_time_on_page),0) AS total_time_on_page,
      coalesce(sum(page_views_for_avg_time),0) AS page_views_for_avg_time
     FROM periods
      LEFT JOIN compass_views ON compass_views.date BETWEEN periods.start_date AND periods.end_date
     GROUP BY is_current_period,start_date,end_date
  ),
  single_number_summary_values AS (
    SELECT
      cur_period.start_date::date AS cur_start_date,
      cur_period.end_date::date AS cur_end_date,
      ref_period.start_date::date AS ref_start_date,
      ref_period.end_date::date AS ref_end_date,
      cur_cv_by_period.total_time_on_page/(cur_cv_by_period.page_views_for_avg_time+(1e-10)) AS cur_average_time_on_page,
      ref_cv_by_period.total_time_on_page/(ref_cv_by_period.page_views_for_avg_time+(1e-10)) AS ref_average_time_on_page,
      cur_cv_by_period.new_user_page_views AS cur_new_user_page_views,
      ref_cv_by_period.new_user_page_views AS ref_new_user_page_views,
      cur_cv_by_period.returning_user_page_views AS cur_returning_user_page_views,
      ref_cv_by_period.returning_user_page_views AS ref_returning_user_page_views,
      cur_cv_by_period.page_views AS cur_total_views,
      ref_cv_by_period.page_views AS ref_total_views
    FROM periods AS cur_period
      LEFT JOIN periods AS ref_period ON ref_period.is_current_period=false
      LEFT JOIN views_by_period AS cur_cv_by_period ON cur_cv_by_period.is_current_period=true
      LEFT JOIN views_by_period AS ref_cv_by_period ON ref_cv_by_period.is_current_period=false
    WHERE cur_period.is_current_period
  ),
  average_time_spent_int AS (
    SELECT round(cur_average_time_on_page)::INT8 AS avg_time_spent
    FROM single_number_summary_values
  ),
  average_time_spent_numeric AS (
    SELECT
      avg_time_spent,
      avg_time_spent / 60 AS minutes,
      MOD(avg_time_spent, 60) AS seconds
    FROM average_time_spent_int
  ),
  average_time_spent_strings_split AS (
    SELECT
      avg_time_spent,
      CASE
        WHEN minutes > 0 THEN minutes::VARCHAR || 'm'
        ELSE ''
      END as minutes_str,
      CASE
        WHEN seconds > 0 OR minutes=0 THEN seconds::VARCHAR || 's'
        ELSE ''
      END as seconds_str
    FROM average_time_spent_numeric
  ),
  average_time_spent AS (
    SELECT
      avg_time_spent,
      CASE
        WHEN minutes_str != '' AND seconds_str != '' THEN minutes_str || ' ' || seconds_str
        WHEN minutes_str = '' THEN seconds_str
        ELSE minutes_str
      END AS average_time_spent_formatted
    FROM average_time_spent_strings_split
  )
  SELECT
    CASE
      WHEN cur_total_views=0 THEN TRUE
      ELSE FALSE
    END AS is_empty_dashboard,
    CASE
      WHEN cur_total_views=0 THEN NULL
      ELSE average_time_spent_formatted
    END AS average_time_spent_formatted,
    CASE
      WHEN cur_total_views=0 THEN NULL
      ELSE avg_time_spent
    END AS average_time_spent,
    CASE
      WHEN cur_total_views=0 THEN NULL
      WHEN ref_average_time_on_page=0 THEN 0
      ELSE (cur_average_time_on_page - ref_average_time_on_page)::FLOAT8/ref_average_time_on_page*100.0
    END ::INT8 AS average_time_spent_percent_change,
    CASE
      WHEN cur_total_views=0 THEN NULL
      ELSE cur_total_views::INT8
    END AS total_views,
    CASE
      WHEN cur_total_views=0 THEN NULL
      WHEN ref_total_views=0 THEN 0
      ELSE (cur_total_views - ref_total_views)::FLOAT8/ref_total_views*100.0
    END ::INT8 AS total_views_percent_change,
    CASE
      WHEN cur_total_views=0 THEN NULL
      ELSE cur_new_user_page_views::INT8
    END ::INT8 AS new_user_page_views,
    CASE
      WHEN cur_total_views=0 THEN NULL
      WHEN ref_new_user_page_views=0 THEN 0
      ELSE (cur_new_user_page_views - ref_new_user_page_views)::FLOAT8/ref_new_user_page_views*100.0
    END ::INT8 AS new_user_page_views_percent_change,
    CASE
      WHEN cur_total_views=0 THEN NULL
      ELSE cur_returning_user_page_views::INT8
    END ::INT8 AS returning_user_page_views,
    CASE
      WHEN cur_total_views=0 THEN NULL
      WHEN ref_returning_user_page_views=0 THEN 0
      ELSE (cur_returning_user_page_views - ref_returning_user_page_views)::FLOAT8/ref_returning_user_page_views*100.0
    END ::INT8 AS returning_user_page_views_percent_change
  FROM single_number_summary_values, average_time_spent

)
SELECT * FROM query_df_463d464d90bedc61180eda1933142c8e

),
listing_total_views AS (
-- Query for dataframe listingViewsSummaryNumbersDataframe(df_b94f70dd344d45f690fdcc32fab0c8d8)
WITH
listing_info_raw AS (
WITH listing_parameters AS (
  -- Note, if listing_id_sha is specified then we want to relax all filters
  -- since listing_id_sha takes priority
  SELECT
    CASE
      WHEN NULL IS NOT NULL THEN NULL
      WHEN NULL IS NOT NULL THEN NULL
      ELSE NULL
    END as specific_listing_status,
    CASE
      WHEN NULL IS NOT NULL THEN FALSE
      WHEN 'all-listings' IS NULL OR 'all-listings' ILIKE 'active%'
        OR 'all-listings' ILIKE 'Coming Soon%' THEN TRUE
      ELSE FALSE
    END AS is_active_only,
    CASE
      WHEN NULL IS NOT NULL THEN TRUE
      WHEN NULL='rental' THEN TRUE
      WHEN NULL='all' THEN TRUE
      WHEN 'all-listings'='active-rentals'
           OR 'all-listings'='all-listings'
        THEN TRUE
      ELSE FALSE
    END AS is_select_rentals,
    CASE
      WHEN NULL IS NOT NULL THEN TRUE
      WHEN NULL='sales' THEN TRUE
      WHEN NULL='all' THEN TRUE
      WHEN 'all-listings'='active-sales'
           OR 'all-listings'='all-listings' THEN TRUE
      ELSE FALSE
    END AS is_select_sales
)
SELECT DISTINCT
  props.property_id_sha AS property_id_sha,
  props.mc_export_property_id_sha AS mc_export_property_id_sha,
  CASE
    WHEN props.is_sales_listing THEN props.pretty_address
    ELSE props.pretty_address || ' (Rental)'
  END AS pretty_address,
  CASE
    WHEN props.is_sales_listing THEN props.display_address
    ELSE props.display_address || ' (Rental)'
  END AS display_address
FROM
  agent_insights_lt.agent_insights__property_by_user
  JOIN agent_insights_lt.agent_insights__properties AS props ON
    props.property_id_sha=agent_insights__property_by_user.property_id_sha
  JOIN agent_insights_lt.agent_insights__agent_info AS agent_info ON
    agent_info.compass_user_id='51269f59e94b802afbb93f48'
  JOIN listing_parameters ON TRUE=TRUE
WHERE
  (agent_insights__property_by_user.compass_user_id = '51269f59e94b802afbb93f48' OR
    (agent_insights__property_by_user.compass_user_external_id IS NOT NULL
      AND agent_insights__property_by_user.compass_user_external_id != ''
      AND agent_insights__property_by_user.compass_user_external_id = agent_info.external_id)
  )
  AND (NULL IS NULL OR props.property_id_sha=NULL)
  AND (specific_listing_status IS NULL OR specific_listing_status='All' OR
  specific_listing_status=props.pretty_listing_status OR
  (specific_listing_status='Active' AND props.pretty_listing_status='Coming Soon'))
  AND (specific_listing_status IS NOT NULL OR NOT is_active_only OR props.is_active)
  AND ((is_select_rentals AND NOT props.is_sales_listing) OR
       (is_select_sales AND is_sales_listing))

),
query_df_b94f70dd344d45f690fdcc32fab0c8d8 AS (
    WITH periods AS (
        SELECT true               AS is_current_period,
               '2020-11-09'::date AS start_date,
               '2020-11-15'::date AS end_date
        UNION ALL
        SELECT false AS is_current_period,
               '2020-11-09'::date +
               INTERVAL '1 day' * ('2020-11-09'::date - '2020-11-15'::date - 1)
                     AS start_date,
               '2020-11-15'::date +
               INTERVAL '1 day' * ('2020-11-09'::date - '2020-11-15'::date - 1)
                     AS end_date
    ),
         compass_views AS (
             SELECT cv.property_id_sha,
                    cv.date,
                    cv.new_user_page_views,
                    cv.returning_user_page_views,
                    cv.new_user_total_time_on_page,
                    cv.returning_user_total_time_on_page,
                    cv.page_views,
                    cv.total_time_on_page,
                    cv.page_views_for_avg_time
             FROM agent_insights_lt.agent_insights__compass_listing_views AS cv
                      JOIN listing_info_raw ON cv.property_id_sha = listing_info_raw.property_id_sha
         ),

         compass_views_by_period AS (
             SELECT is_current_period,
                    start_date,
                    end_date,
                    coalesce(sum(new_user_page_views), 0)               AS new_user_page_views,
                    coalesce(sum(returning_user_page_views), 0)         AS returning_user_page_views,
                    coalesce(sum(new_user_total_time_on_page), 0)       AS new_user_total_time_on_page,
                    coalesce(sum(returning_user_total_time_on_page), 0) AS returning_user_total_time_on_page,
                    coalesce(sum(page_views), 0)                        AS page_views,
                    coalesce(sum(total_time_on_page), 0)                AS total_time_on_page,
                    coalesce(sum(page_views_for_avg_time), 0)           AS page_views_for_avg_time
             FROM periods
                      LEFT JOIN compass_views ON compass_views.date BETWEEN periods.start_date AND periods.end_date
             GROUP BY is_current_period, start_date, end_date
         ),
         other_publisher_views AS (
             SELECT clv.date,
                    clv.streeteasy_page_views,
                    clv.trulia_page_views,
                    clv.zillow_page_views,
                    clv.realtor_page_views
             FROM agent_insights_lt.agent_insights__combined_listing_views AS clv
                      JOIN listing_info_raw ON clv.property_id_sha = listing_info_raw.property_id_sha
         ),
         other_publisher_views_by_period AS (
             SELECT is_current_period,
                    start_date,
                    end_date,
                    coalesce(sum(streeteasy_page_views), 0) AS streeteasy_page_views,
                    coalesce(sum(trulia_page_views), 0)     AS trulia_page_views,
                    coalesce(sum(zillow_page_views), 0)     AS zillow_page_views,
                    coalesce(sum(realtor_page_views), 0)    AS realtor_page_views
             FROM periods
                      LEFT JOIN other_publisher_views ON
                 other_publisher_views.date BETWEEN periods.start_date AND periods.end_date
             GROUP BY is_current_period, start_date, end_date
         ),
         single_number_summary_values AS (
             SELECT cur_period.start_date::date                                                                AS cur_start_date,
                    cur_period.end_date::date                                                                  AS cur_end_date,
                    ref_period.start_date::date                                                                AS ref_start_date,
                    ref_period.end_date::date                                                                  AS ref_end_date,
                    cur_cv_by_period.total_time_on_page /
                    (cur_cv_by_period.page_views_for_avg_time + (1e-10))                                       AS cur_average_time_on_page,
                    ref_cv_by_period.total_time_on_page /
                    (ref_cv_by_period.page_views_for_avg_time + (1e-10))                                       AS ref_average_time_on_page,
                    cur_cv_by_period.new_user_page_views                                                       AS cur_new_user_page_views,
                    ref_cv_by_period.new_user_page_views                                                       AS ref_new_user_page_views,
                    (cur_cv_by_period.page_views + cur_op_by_period.streeteasy_page_views +
                     cur_op_by_period.realtor_page_views +
                     cur_op_by_period.trulia_page_views +
                     cur_op_by_period.zillow_page_views)                                                       AS cur_total_views,
                    (ref_cv_by_period.page_views + ref_op_by_period.streeteasy_page_views +
                     ref_op_by_period.realtor_page_views +
                     ref_op_by_period.trulia_page_views +
                     ref_op_by_period.zillow_page_views)                                                       AS ref_total_views
             FROM periods AS cur_period
                      LEFT JOIN periods AS ref_period ON ref_period.is_current_period = false
                      LEFT JOIN compass_views_by_period AS cur_cv_by_period ON cur_cv_by_period.is_current_period = true
                      LEFT JOIN compass_views_by_period AS ref_cv_by_period
                                ON ref_cv_by_period.is_current_period = false
                      LEFT JOIN other_publisher_views_by_period AS cur_op_by_period
                                ON cur_op_by_period.is_current_period = true
                      LEFT JOIN other_publisher_views_by_period AS ref_op_by_period
                                ON ref_op_by_period.is_current_period = false
             WHERE cur_period.is_current_period
         ),
         average_time_spent_int AS (
             SELECT round(cur_average_time_on_page)::INT8 AS avg_time_spent
             FROM single_number_summary_values
         ),
         average_time_spent_numeric AS (
             SELECT avg_time_spent,
                    avg_time_spent / 60     AS minutes,
                    MOD(avg_time_spent, 60) AS seconds
             FROM average_time_spent_int
         ),
         average_time_spent_strings_split AS (
             SELECT avg_time_spent,
                    CASE
                        WHEN minutes > 0 THEN minutes::VARCHAR || 'm'
                        ELSE ''
                        END as minutes_str,
                    CASE
                        WHEN seconds > 0 OR minutes = 0 THEN seconds::VARCHAR || 's'
                        ELSE ''
                        END as seconds_str
             FROM average_time_spent_numeric
         ),
         average_time_spent AS (
             SELECT avg_time_spent,
                    CASE
                        WHEN minutes_str != '' AND seconds_str != '' THEN minutes_str || ' ' || seconds_str
                        WHEN minutes_str = '' THEN seconds_str
                        ELSE minutes_str
                        END AS average_time_spent_formatted
             FROM average_time_spent_strings_split
         )
    SELECT CASE
               WHEN cur_total_views = 0 THEN TRUE
               ELSE FALSE
               END        AS is_empty_dashboard,
           CASE
               WHEN cur_total_views = 0 THEN NULL
               ELSE average_time_spent_formatted
               END        AS average_time_spent_formatted,
           CASE
               WHEN cur_total_views = 0 THEN NULL
               ELSE avg_time_spent
               END        AS average_time_spent,
           CASE
               WHEN cur_total_views = 0 THEN NULL
               WHEN ref_average_time_on_page = 0 THEN 0
               ELSE (cur_average_time_on_page - ref_average_time_on_page)::FLOAT8 /
                    (ref_average_time_on_page + (1e-10)) * 100.0
               END ::INT8 AS average_time_spent_percent_change,
           CASE
               WHEN cur_total_views = 0 THEN NULL
               ELSE cur_total_views::INT8
               END        AS total_views,
           CASE
               WHEN cur_total_views = 0 THEN NULL
               WHEN ref_total_views = 0 THEN 0
               ELSE (cur_total_views - ref_total_views)::FLOAT8 / (ref_total_views + (1e-10)) * 100.0
               END ::INT8 AS total_views_percent_change,
           CASE
               WHEN cur_total_views = 0 THEN NULL
               ELSE cur_new_user_page_views::INT8
               END ::INT8 AS new_user_page_views,
           CASE
               WHEN cur_total_views = 0 THEN NULL
               WHEN ref_new_user_page_views = 0 THEN 0
               ELSE (cur_new_user_page_views - ref_new_user_page_views)::FLOAT8 / (ref_new_user_page_views + (1e-10)) *
                    100.0
               END ::INT8 AS new_user_page_views_percent_change
    FROM single_number_summary_values,
         average_time_spent
)
SELECT * FROM query_df_b94f70dd344d45f690fdcc32fab0c8d8
),
         profile_total_views AS (
          WITH
         query_df_profile_total_views AS (
          WITH
            periods AS (
              SELECT
                true AS is_current_period,
                '2020-11-09'::DATE AS start_date,
                '2020-11-15'::DATE AS end_date
              UNION ALL
              SELECT
                false AS is_current_period,
                '2020-11-09'::DATE +
                  INTERVAL'1 day'*('2020-11-09'::DATE-'2020-11-15'::DATE-1)
                AS start_date,
                '2020-11-15'::DATE +
                  INTERVAL'1 day'*('2020-11-09'::DATE-'2020-11-15'::DATE-1)
            ),
            compass_views AS (
              SELECT
                pv.compass_user_id,
                pv.date,
                pv.new_user_page_views,
                pv.returning_user_page_views,
                pv.new_user_total_time_on_page,
                pv.returning_user_total_time_on_page,
                pv.page_views,
                pv.total_time_on_page,
                pv.page_views_for_avg_time
               FROM agent_insights_lt.agent_insights__agent_profile_views_by_user_type AS pv
               WHERE
                compass_user_id = '51269f59e94b802afbb93f48'
            ),
            compass_views_by_period AS (
              SELECT
                is_current_period,
                start_date,
                end_date,
                coalesce(sum(new_user_page_views),0) AS new_user_page_views,
                coalesce(sum(returning_user_page_views),0) AS returning_user_page_views,
                coalesce(sum(new_user_total_time_on_page),0) AS new_user_total_time_on_page,
                coalesce(sum(returning_user_total_time_on_page),0) AS returning_user_total_time_on_page,
                coalesce(sum(page_views),0) AS page_views,
                coalesce(sum(total_time_on_page),0) AS total_time_on_page,
                coalesce(sum(page_views_for_avg_time),0) AS page_views_for_avg_time
               FROM periods
                LEFT JOIN compass_views ON compass_views.date BETWEEN periods.start_date AND periods.end_date
               GROUP BY is_current_period,start_date,end_date
            ),
            single_number_summary_values AS (
              SELECT
                cur_period.start_date::date AS cur_start_date,
                cur_period.end_date::date AS cur_end_date,
                ref_period.start_date::date AS ref_start_date,
                ref_period.end_date::date AS ref_end_date,
                cur_pv_by_period.total_time_on_page/(cur_pv_by_period.page_views_for_avg_time+(1e-10)) AS cur_average_time_on_page,
                ref_pv_by_period.total_time_on_page/(ref_pv_by_period.page_views_for_avg_time+(1e-10)) AS ref_average_time_on_page,
                cur_pv_by_period.new_user_page_views AS cur_new_user_page_views,
                ref_pv_by_period.new_user_page_views AS ref_new_user_page_views,
                cur_pv_by_period.page_views AS cur_total_views,
                ref_pv_by_period.page_views AS ref_total_views
              FROM periods AS cur_period
                LEFT JOIN periods AS ref_period ON ref_period.is_current_period=false
                LEFT JOIN compass_views_by_period AS cur_pv_by_period ON cur_pv_by_period.is_current_period=true
                LEFT JOIN compass_views_by_period AS ref_pv_by_period ON ref_pv_by_period.is_current_period=false
              WHERE cur_period.is_current_period
            ),
            average_time_spent_int AS (
              SELECT round(cur_average_time_on_page)::INT8 AS avg_time_spent
              FROM single_number_summary_values
            ),
            average_time_spent_numeric AS (
              SELECT
                avg_time_spent,
                avg_time_spent / 60 AS minutes,
                MOD(avg_time_spent, 60) AS seconds
              FROM average_time_spent_int
            ),
            average_time_spent_strings_split AS (
              SELECT
                avg_time_spent,
                CASE
                  WHEN minutes > 0 THEN minutes::VARCHAR || 'm'
                  ELSE ''
                END as minutes_str,
                CASE
                  WHEN seconds > 0 OR minutes=0 THEN seconds::VARCHAR || 's'
                  ELSE ''
                END as seconds_str
              FROM average_time_spent_numeric
            ),
            average_time_spent AS (
              SELECT
                avg_time_spent,
                CASE
                  WHEN minutes_str != '' AND seconds_str != '' THEN minutes_str || ' ' || seconds_str
                  WHEN minutes_str = '' THEN seconds_str
                  ELSE minutes_str
                END AS average_time_spent_formatted
              FROM average_time_spent_strings_split
            )
            SELECT
              CASE
                WHEN cur_total_views=0 THEN TRUE
                ELSE FALSE
              END AS is_empty_dashboard,
              CASE
                WHEN cur_total_views=0 THEN NULL
                ELSE average_time_spent_formatted
               END AS average_time_spent_formatted,
               CASE
                 WHEN avg_time_spent=0 THEN NULL
                 ELSE avg_time_spent
              END AS average_time_spent,
              CASE
                WHEN cur_total_views::INT8=0 THEN NULL
                WHEN ref_average_time_on_page=0 THEN 0
                ELSE (cur_average_time_on_page - ref_average_time_on_page)::FLOAT8/ref_average_time_on_page*100.0
              END ::INT8 AS average_time_spent_percent_change,
              CASE
                WHEN cur_total_views::INT8=0 THEN NULL
                ELSE cur_total_views::INT8
              END AS total_views,
              CASE
                WHEN cur_total_views::INT8=0 THEN NULL
                WHEN ref_total_views=0 THEN 0
                ELSE (cur_total_views - ref_total_views)::FLOAT8/ref_total_views*100.0
              END ::INT8 AS total_views_percent_change,
              CASE
                WHEN cur_total_views::INT8=0 THEN NULL
                ELSE cur_new_user_page_views
              END AS new_user_page_views,
              CASE
                WHEN cur_total_views::INT8=0 THEN NULL
                WHEN ref_new_user_page_views=0 THEN 0
                ELSE (cur_new_user_page_views - ref_new_user_page_views)::FLOAT8/ref_new_user_page_views*100.0
              END ::INT8 AS new_user_page_views_percent_change
            FROM single_number_summary_values, average_time_spent
)
SELECT * FROM query_df_profile_total_views
     )

SELECT
lv.is_empty_dashboard AND pv.is_empty_dashboard AND cv.is_empty_dashboard AS is_empty_dashboard
FROM listing_total_views AS lv, profile_total_views AS pv, collection_total_views as cv
;
