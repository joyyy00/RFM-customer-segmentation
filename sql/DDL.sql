
-- Transaction table: Base table that holds all online transactions 
create table transactions (
	invoice VARCHAR(50),
	stock_code VARCHAR(50),
	description TEXT,
	quantity INT,
	invoice_date TIMESTAMP,
	price NUMERIC(10,2),
	customer_id VARCHAR(50),
	country VARCHAR(50),
	total_price NUMERIC(10,2)
);


