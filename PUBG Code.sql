---read data
select
  * 
from
  dbo.PUBG_Data;

--- how many rows
select 
  count(*)
from
  PUBG_Data

---the probability of winning for each match type
SELECT 
  distinct(matchType), 
  avg(winPlacePerc) as perc_of_winning 
from 
  dbo.PUBG_Data 
group by 
  matchType

--- as its predicted that the winning percentage near to 0.5 

--- number of kills for battle winners
select 
  kills as kills_num
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1 
order by 
  kills_num desc;

---range of kills for winners
select 
  max(kills) - min(kills) 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;

---it seems hard for a player to kill 65 enemy in one game, it seems to have outliers in kills column(may be they were hackers?!) 

--- average number of kills for batlle winners
select 
  round(
    avg(kills), 
    0
  ) as avg_kills 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;

---average number of kills for winners according to macth type
select 
  matchType, 
  round(
    avg(kills), 
    0
  ) as kills_num 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1 
group by 
  matchType
order by kills_num desc;

---the expected damage death for winners
select 
  round(
    avg(damageDealt), 
    2
  ) expected_damage 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;
---and lets compare expected damage for winners with average damage players
select 
  round(
    avg(damageDealt), 
    2
  ) expected_damage 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc < 1;

--- number of battle winning if player assist teammate(help teammates in the fights in the game 
select 
  count(winPlacePerc) as battle_win_withAssists 
from 
  dbo.PUBG_Data 
where 
  assists > 0;

---percentage of winning the battle if players help thier teammates 
select 
  Top 1 (
    select 
      round(
        avg(winPlacePerc), 
        2
      ) 
    from 
      dbo.PUBG_Data 
    where 
      assists > 0
  ) as percent_win 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;

---how much times winners knocked enemies down
select 
  round(
    avg(DBNOs), 
    0
  ) average_players_knocked 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;

---average win points if you are a winner
select 
  round(
    avg(winPoints), 
    0
  ) as win_points
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;

---if you are a winner, how many the expected points to win
select 
  max(winPoints) - min(winPoints) 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;

---number of heals winners would take during the match
select 
  round(
    avg(heals), 
    0
  ) 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;
---number of boosts winners would take during the match
select 
  round(
    avg(boosts), 
    0
  ) 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;
---walk distance for winners
select 
  round(
    avg(walkDistance), 
    2
  ) as expected_walk_distance 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;
---swim distance for winners
select 
  round(
    avg(swimDistance), 
    2
  ) as expected_swim_distance 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;
---ride distance for winners
select 
  round(
    avg(rideDistance), 
    2
  ) as expected_ride_distance 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1;

---number of matches played
select 
  distinct(matchType), 
  count(matchType) as num_of_matches 
from 
  dbo.PUBG_Data 
group by 
  matchType 
order by 
  num_of_matches desc;
---number of winners for each match type
select 
  distinct(matchType), 
  count(winPlacePerc) as num_winning 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1 
group by 
  matchType 
order by 
  num_winning desc;

---the longest kill ever in pubg mobile
select 
  max(longestKill) 
from 
  dbo.PUBG_Data;

---average match duration in seconds
select 
  round(
    avg(matchduration), 
    0
  ) as match_duration 
from 
  dbo.PUBG_Data;

---average match duration in seconds for each match type
select 
  distinct(matchType), 
  round(
    avg(matchduration), 
    0
  ) as match_duration 
from 
  dbo.PUBG_Data 
group by 
  matchType 
order by 
  match_duration desc;

---cummulative kill points for each match group and each match type
select 
  id, 
  matchId, 
  killPoints, 
  CUME_DIST() over (
    partition by matchId 
    order by 
      killPoints
  ) cumulative_killpoints_percentile 
from 
  dbo.PUBG_Data;

---rank over highest kills and highest kill points for each match
select 
  Id, 
  matchId, 
  killPoints, 
  rank() over(
    order by 
      matchId, 
      killPoints desc
  ) as kill_points_rank 
from 
  dbo.PUBG_Data

---divide rankPoints to four quartiles for winners with rank > 0
select 
  rankPoints, 
  ntile(4) over(
    order by 
      rankPoints desc
  ) 
from 
  dbo.PUBG_Data 
where 
  winPlacePerc = 1 
  and rankPoints > 0;

---how many kills repeated
select 
  distinct kills, 
  count(kills) as num_kills 
from 
  dbo.PUBG_Data 
group by 
  kills 
order by 
  num_kills desc;

--- let's discover when the highest kills happened(may be he was a hacker)
select 
  max(longestKill) longest_kills_distance 
from 
  dbo.PUBG_Data;

select 
  * 
from 
  dbo.PUBG_Data 
where 
  longestKill = 1094;
---as a pubg player: I think he was not a hacker

--- let's discover when the highest kills happened
select 
  max(kills) 
from 
  dbo.PUBG_Data;

select 
  * 
from 
  dbo.PUBG_Data 
where 
  kills = 65;
---as a pubg player: I think he was a hacker becaues most of his kills come from headshots
---how he was able to kill all those people around whole the map without taking a vehicle?!!

---in the end, this was a quick exploration of PUBG Mobile data, and I had some conclusions would write in PDF



 



