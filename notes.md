# DB for Usher platform

- PostgreSQL
- Tables:
    - <s>Users</s>
    - Reviews
    - <s>Rides</s>
- Users table should has type of user, e.g. Driver or Customer
- Users table should use an ID as unique primary key
- Reviews should be normalized as for now, maybe if performance will be an issue denormalized
- Reviews table should has Rides ID as foreign key, Users ID should be also a foreign key or deducted from Rides? or the opposite?
- Rides table should has Customer and Driver IDs as foreign keys, maybe the latter should be optional what to with pending Rides? Save them?
- Rides table should has ID as unique primary key
- Reviews table should has ID as unique primary key
- TODO ER diagram
