
-- RFM metrics table calculating recency, frequency, and monetary value
create table customer_rfm as 
select customer_id,
	('2011-12-10'::date - max(invoice_date)::date) as recency ,
	count(customer_id) as frequency,
	sum(total_price) as monetary_val
from transactions 
group by customer_id;

