## Notes in Helm Chart
- It contents what is going to display on the terminal when someone download and install your chart or when you install the chart.
- You need to create a file call `NOTES.txt`

```yml
Thank you for support {{ .Chart.Name }}.
 
Your release is named {{ .Release.Name }}.
 
To learn more about the release, try:
 
   $ helm status {{ .Release.Name }}
   $ helm get all {{ .Release.Name }}
   $ helm uninstall {{ .Release.Name }}
```

**RESULT:**
```yml
NOTES:
Thank you for support mychart.
 
Your release is named demo.
 
To learn more about the release, try:
 
   $ helm status demo
   $ helm get all demo
   $ helm uninstall demo
root@ubuntu:~# helm uninstall demo
release "demo" uninstalled
```

