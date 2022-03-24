## Cronb Job In Linux
- It is a tool used in linux to schedule tasks. This task can be a single command or a whole script
- The crontab is used for running specific tasks on a regular interval. 
- Linux crontab is similar to windows task schedules. 
- Crontab executes jobs automatically in the backend at a specified time and interval.

### To schedule a crontab 
```
crontab -e 
```

### List a cronb jobs
```
crontab -l
```

### To delete a cronb job
```
crontab -r
```

### Linux crontab format
![](/images/cront1.JPG)

### Crontab Webside
[Website to schedule a cronb job](https://crontab.guru/)

![](/images/cront3.JPG)

### Schedule a cron to execute on every 10 minutes.
If you want to run your script on a 10 minutes interval, you can configure it like below. These types of crons are useful for monitoring.
```
*/10 * * * * sh /scripts/monitor.sh
```

***/10:** means to run every `10` minutes. Same as if you want to execute on every 5 minutes use `*/5`.

### Schedule a cron to execute every minute.
Generally, we don’t require any script to execute every minute but in some cases, you may need to configure it.
```
* * * * *  sh /scripts/script.sh
```

### Schedule a cron to execute twice a day.
Below example command will execute at 5 AM and 5 PM daily. You can specify multiple timestamps by comma-separated.
```
0 5,17 * * * sh /scripts/script.sh
```

### Schedule a cron to execute on selected months.
Sometimes we required scheduling a task to be executed for selected months only. Below example script will run in January, May and August months.
```
* * * jan,may,aug *  sh /script/script.sh
```

### Schedule a cron to execute on selected days.
If you required scheduling a task to be executed for selected days only. The below example will run on each Sunday and Friday at 5 PM.
```
0 17 * * sun,fri  sh /script/script.sh
```

### Schedule multiple tasks in a single cron.
To configure multiple tasks with a single cron, Can be done by separating tasks by the semicolon ( ; ).
```
* * * * * sh /scripts/script.sh; /scripts/scrit2.sh
```
## Example 1
This will echo Hello every minutes
```
* * * * * echo "Hello" >> /tmp/test.txt
crontab -e
crontab -r
```

## Example 2
Crontab that will delete every file in the tmp directory every minute

```
cd /home
vim tmp.sh
```

```
#!bin/bash
cd /tmp
rm -rf *
```
```
chmod +x tmp.sh
```
```
crontab -e
* * * * * sh /home/tmp.sh
```

### Crontab that will delete every file in the tmp directory every minute
```
crontab -e
* * * * * rm -rf /tmp/*
```

## Use special string to save time
Instead of the first five fields, you can use any one of eight special strings. It will not just save your time but it will improve readability.
![](/images/cront2.JPG)

### 1.Schedule tasks to execute on yearly ( @yearly ).
@yearly timestamp is similar to `0 0 1 1 *`. It will execute a task on the first minute of every year, It may useful to send new year greetings 
```
@yearly /scripts/script.sh
```
### 2. Schedule tasks to execute on monthly ( @monthly ).
@monthly timestamp is similar to `0 0 1 * *`. It will execute a task in the first minute of the month. It may be useful to do monthly tasks like paying the bills and invoicing to customers.
```
@monthly sh /scripts/script.sh
```

### 3. Schedule tasks to execute on Weekly ( @weekly ).
@weekly timestamp is similar to `0 0 1 * mon`. It will execute a task in the first minute of the week. It may be useful to do weekly tasks like the cleanup of the system etc.
```
@weekly sh /bin/script.sh
```

### 4. Schedule tasks to execute on daily ( @daily ).
@daily timestamp is similar to `0 0 * * *`. It will execute a task in the first minute of every day. It may be useful to do daily tasks.
```
@daily sh /scripts/script.sh
```

### 5. Schedule tasks to execute on hourly ( @hourly ).
@hourly timestamp is similar to `0 * * * *`. It will execute a task in the first minute of every hour, It may be useful to do hourly tasks.
```
@hourly sh /scripts/script.sh
```

### 6. Schedule tasks to execute on system reboot ( @reboot ).
@reboot is useful for those tasks which you want to run on your system startup. It will be the same as system startup scripts. It is useful for starting tasks in the background automatically.
```
@reboot sh /scripts/script.sh
```
docker-clean-up.sh

0 2 * * * bash /root/useradd -a
0 3 * * * bash /root/docker-clean-up.sh