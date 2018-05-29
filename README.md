This was a project to integrate all information from checkpoint firewalls into alienvault.
I have used loggrabber-fw1 on another big server and sent this to another analysis server through (ELK) filebeat.
To combine information, and sent alerts the whole OSSEC ruling and alerting had to be rewritten.
The Alienvault database had to be reverse engineered, to output text in human readable format instead of HEX.

Note: The newer firmware versions from checkpoint do allow native API calls to retrieve information, which make things much easier.



