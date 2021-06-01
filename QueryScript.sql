use 4710_Project;

#query 1
select address from house;

#query 2
select address, mlsNumber from Listings where address in (select address from house);

#query 3
select address from House where bedrooms = 3 and bathrooms = 2;

#query 4
select address, price from property where (price <= 250000 ) and (price >= 100000) 
and address in (select address from house where (bedrooms = 3) and (bathrooms = 2))
order by price desc;

#query 5
select address, price from property where address in 
(select address from BusinessProperty where type = 'Office')
order by price desc;

#query 6
select Agent.agentId, Agent.name, Agent.phone, Firm.name, Agent.dateStarted
from Agent right join Firm on Agent.firmId = Firm.id;

#query 7
select * from property 
where property.address in (select address from listings where listings.agentId = 84607);

#query 8
select a.name as 'Agent Name', b.name as 'Buyer Name' from works_with 
	right join Agent as a on works_with.agentId = a.agentId
	right join Buyer as b on works_with.buyerId = b.id
order by a.name asc;

#query 9
select agentId, count(BuyerId) as 'count' from works_with group by agentId;

#query 10
select h.bedrooms, h.bathrooms, h.size, h.address, p.price from house as h
	inner join Buyer as b on b.id = 19167
    right join Property as p on h.address = p.address
		where h.bedrooms = b.bedrooms and h.bathrooms = b.bathrooms
        and p.price <= b.maximumpreferredprice and p.price >= b.maximumpreferredprice
order by p.price desc;
