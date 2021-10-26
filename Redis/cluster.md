# Redis Sentinel — High Availability
- Redis Sentinel — High Availability: Everything you need to know from DEV to PROD: Complete Guide [here](https://medium.com/@amila922/redis-sentinel-high-availability-everything-you-need-to-know-from-dev-to-prod-complete-guide-deb198e70ea6
)
- Redis High Availability Architecture with Sentinel [here](https://severalnines.com/database-blog/redis-high-availability-architecture-sentinel)

- Active Replica Setup [here](https://docs.keydb.dev/docs/active-rep/)

- How to Setup Redis For High Availability with Sentinel in CentOS 8 [here](https://www.tecmint.com/setup-redis-high-availability-with-sentinel-in-centos-8/)

![](/images/redis19.JPG)

### Redis sentinel vs clustering [here](https://stackoverflow.com/questions/31143072/redis-sentinel-vs-clustering)

- Sentinel manages the failover, it doesn't configure Redis for HA.
- Another reason for running two slaves would be to split reads
- HA Redis requires several pieces to be HA. Sentinel only handles one piece: the failover.
- You configure Redis replication by setting up slaves. Then sentinel will discover it and manage failovers. Sentinel can not set up replication as it only manages an existing replication setup
- Redis Sentinel is simply a way to perform automatic fail over when a master instance is not functioning correctly.
- Redis Sentinel is a system designed to **manage master and slave**. It runs as separate program. The minimum number of sentinels required in an ideal system is **3**. They communicate among themselves and make sure that the **Master is alive**, if not alive they will promote one of the slaves as master, so later when the dead node spins up it will be acting as a slave for the new master
- Quorum is configurable. Basically it is the number of sentinels that need to agree as the master is down
- Redis Sentinel performs the failover promoting replicas when they see a master is down

### What is the difference between replication fault tolerance and high availability [here](https://www.youtube.com/watch?v=miEHdzqlRsY)

This is a question that gets asked a lot, from people who have had years of experience within the IT industry, and those who are new and just starting out. Either way, there is clearly some confusion between the two, and understandably so. They both ultimately have the same goal, to keep your systems up and running should something fail within your architecture, but there is a difference.

- High Availability can be defined by maintaining a percentage of uptime that maintains operational performance, and so this can closely be aligned to an SLA.  In fact, AWS has many SLAs for its services where they implement their own level of resilience and management to maintain that level of high availability. 

- Fault Tolerance expands on High Availability to offer a greater level of protection should components begin to fail in your infrastructure. However, there are usually additional cost implications due to the greater level of resiliency offered.  But the upside is that your uptime percentage increases and there is no interruption of service should 1 or more components fail.  

