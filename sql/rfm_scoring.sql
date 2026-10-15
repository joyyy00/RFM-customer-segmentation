
-- Assign scores
create table rfm_scores as
with rfm_calc as (
	select 
		customer_id,
		recency,
		frequency,
		monetary_val
	from customer_rfm
),
rfm_ntile as (
	select 
		customer_id,
		recency,
		frequency,
		monetary_val,
		-- 5 buckets: 5 = best, 1 = bad
		-- Lower recency number is better
		ntile(5) over (order by recency desc) as rec_score,
		-- Higher frequency is better
		ntile(5) over (order by frequency asc) as freq_score,
		-- Higher monetary value is better
		ntile(5) over (order by monetary_val asc) as mv_score
	from rfm_calc
) 
select 
	customer_id,
	recency,
	frequency,
	monetary_val,
	rec_score,
	freq_score,
	mv_score,
	(rec_score::TEXT || freq_score::TEXT || mv_score::TEXT) as rfm_combined_score
from rfm_ntile;

