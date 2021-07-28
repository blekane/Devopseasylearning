## Write a shell script that will do the following:
1. Check if the CPU is at least 4000 
2. Check if the user admin exists on the server, if not create a user admin with the password=redhat and give him root privilege.
3. Check if a group helpdesk exists on the server. If not, create a group helpdesk, add paul, John, tom (password = "redhat") and give them root privilege to reset other users' passwords only . 
**NB: make sure that you expire users account**
4. Check if the memory is at least 8G 
5. Check the first digit of the  Kernel version is at least 3 and above 
6. Check if the root file system is not more than 10% 
7. Check if selinux is set to enforcing, if not enforced it 
8. Check if the OS version is CentOs 6 or 7 
9. Check if the default runlevel is 3. If not, set it to 3. 
10. Check if cron.allow is present on the server. If not, create it. 
11. Check if sshd port 22 is open. If yes, close port 22
12. Change the default ssh port to 29 
13. Check if port 8080 is open. If not open port 8080 
14. Check if port 80 is open on the server. If not, open port 80 
15. Check if the password hash is SHA512. If not, change to SHA512 
16. Check if password authentication is set to yes in the ssh_config file. If no, set it to yes. 
17. Check if the server will require a root for maintenance mode. If not, set it to require root password for maintenance mode.
18. Check if the password aging is enforced. If not, enforced it:
    - SET PASS_MAX_DAYS TO 90 DAYS 
    - SET PASS_MIN_LEN TO 8 
    - SET PASS_MIN_LEN TO 0 
    - SET PASS_WARN_AGE TO 14 DAYS 
19. Check if the grub password is set. If not, set the grub password. The password should be "redhat" 

