CREATE DATABASE agent_insights_lt;
USE agent_insights_lt;


create table agent_insights_lt.agent_insights__collection_display_name
(
    compass_user_id         varchar(256),
    collection_id           varchar(32),
    collection_display_name varchar(1284)
);

create index idx_60b98aa31139950cee7db102a2ff5898521d07a29867c20271809c17
    on agent_insights_lt.agent_insights__collection_display_name (compass_user_id, collection_id);


create table agent_insights_lt.agent_insights__collection_views
(
    collection_id                     varchar(32),
    date                              date,
    new_user_page_views               bigint,
    returning_user_page_views         bigint,
    new_user_total_time_on_page       bigint,
    returning_user_total_time_on_page bigint,
    page_views                        bigint,
    total_time_on_page                bigint,
    page_views_for_avg_time           bigint
);

create index idx_be2b7de1117a4e582e851c0ec71567104a24fba5101578b7ab903ee0
    on agent_insights_lt.agent_insights__collection_views (collection_id, date);


create table agent_insights_lt.agent_insights__property_by_user
(
    compass_user_id          varchar(256),
    property_id_sha          varchar(80),
    compass_user_external_id varchar(256)
);

create index idx_948da45d877283c79f008054178e2eba8fb100a3f056f3df83e3932e
    on agent_insights_lt.agent_insights__property_by_user (compass_user_id, property_id_sha, compass_user_external_id);

create index idx_f059d4b92d7a37c5a5081f182c71d8464736da554995471546a94c1a
    on agent_insights_lt.agent_insights__property_by_user (property_id_sha, compass_user_id, compass_user_external_id);

create index idx_25c5543e0cb7bff8ee23d5ecfa59c951ff28510ff6718b0bc5f8a791
    on agent_insights_lt.agent_insights__property_by_user (compass_user_external_id);


create table agent_insights_lt.agent_insights__properties
(
    property_id               varchar(256),
    property_id_sha           varchar(80),
    is_sales_listing          boolean,
    mc_export_property_id_sha varchar(80),
    is_active                 boolean,
    pretty_address            varchar(5125),
    city                      varchar(64),
    state                     varchar(64),
    zip_code                  varchar(16),
    display_address           varchar(5875),
    pretty_listing_status     varchar(32)
);

create index idx_2a26fe13fbf3132847159d2eaecd876b2d520129a416bae77e659f3d
    on agent_insights_lt.agent_insights__properties (property_id_sha, is_active, is_sales_listing, pretty_listing_status);

create index idx_5fef589250b386dea26493db0a864b79e6aee7570915bb1c70e6d993
    on agent_insights_lt.agent_insights__properties (property_id_sha, is_sales_listing, pretty_listing_status);

create index idx_cfa6b8e411b751ac9afdc7faa50f00a8d000363fefafe72abb8838e6
    on agent_insights_lt.agent_insights__properties (property_id_sha, pretty_listing_status, is_active, is_sales_listing);

create index idx_da643322eac3f44e556c71f8e8222f1cd561a57ce30c544bc01dcc53
    on agent_insights_lt.agent_insights__properties (property_id_sha, pretty_listing_status, is_sales_listing);


create table agent_insights_lt.agent_insights__agent_info
(
    compass_user_id       varchar(256),
    -- agent_email           varchar(65535),
    agent_email           varchar(256),
    agent_name            varchar(513),
    agent_geo             varchar(256),
    is_agent_team         boolean,
    agent_team_user_id    varchar(256),
    normalized_url        varchar(521),
    external_id           varchar(256),
    normalized_url_no_geo varchar(521)
);

create index idx_f03b045b9b642b7a9fae5c1b0205751a978ece44fbac21f0e17c912a
    on agent_insights_lt.agent_insights__agent_info (compass_user_id, external_id);

create index idx_917266c163f49d72cebd7a2e9b09bc85e41b07110f8bf0cbdedb5206
    on agent_insights_lt.agent_insights__agent_info (normalized_url);

create index idx_7bca76cd742fd0b66abf9e5cec521b14a953e9726525eb893208041e
    on agent_insights_lt.agent_insights__agent_info (normalized_url_no_geo);


create table agent_insights_lt.agent_insights__compass_listing_views
(
    property_id_sha                   varchar(80),
    date                              date,
    new_user_page_views               bigint,
    returning_user_page_views         bigint,
    new_user_total_time_on_page       bigint,
    returning_user_total_time_on_page bigint,
    page_views                        bigint,
    total_time_on_page                bigint,
    page_views_for_avg_time           bigint
);

create index idx_25e6793be01a1178597c0a391473cadce97ac0e52cac39300474a022
    on agent_insights_lt.agent_insights__compass_listing_views (property_id_sha, date);


create table agent_insights_lt.agent_insights__combined_listing_views
(
    property_id_sha       varchar(80),
    date                  date,
    compass_page_views    bigint,
    streeteasy_page_views bigint,
    trulia_page_views     bigint,
    zillow_page_views     bigint,
    realtor_page_views    bigint
);

create index idx_ceaaea6cba1cedb232166c1082ade85a3df9a13ab6603cc9635b9984
    on agent_insights_lt.agent_insights__combined_listing_views (property_id_sha, date);


create table agent_insights_lt.agent_insights__agent_profile_views_by_user_type
(
    compass_user_id                   varchar(256),
    date                              date,
    new_user_page_views               bigint,
    returning_user_page_views         bigint,
    new_user_total_time_on_page       bigint,
    returning_user_total_time_on_page bigint,
    page_views                        bigint,
    total_time_on_page                bigint,
    page_views_for_avg_time           bigint
);

create index idx_ad6b33ac2bb24b82f311cf3eef4e98423423eab57fc1e0a79ba001d3
    on agent_insights_lt.agent_insights__agent_profile_views_by_user_type (compass_user_id, date, page_views);


-- DROP DATABASE agent_insights_lt;
