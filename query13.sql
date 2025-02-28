/*
    Which station is furthest from Meyerson Hall?

    Your query should return only one line, and only give the station id
    (station_id), station name (station_name), and distance (distance) from
    Meyerson Hall, rounded to the nearest 50 meters.
*/

with
meyerson as (
    select
        st_setsrid(
            st_makepoint(-75.192584, 39.952415),
            4326
        ) as meyerson_geog
)

select
    stn.id as station_id,
    stn.name as station_name,
    round(
        st_distance(stn.geog, meyerson.meyerson_geog)
        / 50
    ) * 50
    as distance
from indego.station_statuses as stn, meyerson
order by distance desc
limit 1;
