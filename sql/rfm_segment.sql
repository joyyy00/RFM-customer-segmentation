-- categorizing into segment labels
create table rfm_segment as 
select  
	customer_id,
	recency,
	frequency,
	monetary_val,
	rec_score,
	freq_score,
	mv_score,
	rfm_combined_score,
	case 
		-- bought recently, is frequent, and spends the most
		when rec_score >= 4 and freq_score >= 4 and mv_score >= 4 then 'Champions'
		-- buys regularly and bought fairly recently 
		when freq_score >= 3 and rec_score >= 3 then 'Loyal'
		-- most recent shoppers but not frequent yet
		when rec_score = 5 and freq_score = 1 then 'New Customers'
		-- bought recently, but doesn't buy on a regular basis
		when rec_score >= 3 and freq_score <= 3 then 'Potential Loyalists'
		-- made big purchases, fairly frequent, but hasn't bought in a while 
		when mv_score >= 3 and freq_score >= 3 and rec_score <= 2 then 'Can''t lose them'
		-- low priority 
		when rec_score <= 2 and freq_score <= 2 and mv_score <= 2 then 'Hibernating'
		-- below average recency and frequency 
		when rec_score <= 2 and (freq_score <= 2 OR mv_score <= 2) then 'At risk'
		else 'Other'
	end as rfm_segment	
from rfm_scores;


select * from rfm_segment limit 5;

-- check distribution of segments
select 
    rfm_segment,
    count(*) as customer_count,
	round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage_of_total,
    round(avg(monetary_val), 2) as avg_monetary_value
from rfm_segment
group by rfm_segment
order by avg_monetary_value desc;