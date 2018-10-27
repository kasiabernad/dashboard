SELECT 'Buyer' as kind, buyer_name as name, buyer_tax_number as tax_number FROM invoices
UNION
SELECT 'Seller', firstname || ' ' || surname as name, tax_number FROM users;
