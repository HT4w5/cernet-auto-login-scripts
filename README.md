# CERNET Auto Login Script

## Introduction

Tired of logging in manually while using CERNET? Use this script on your router!

Automates web portal login. DOES NOT REPLACE PPPoE!

Works in the you-know-which institution's dorms, via wired connection.

Tested on alpine 3.18 Proxmox LXC. Should work on any distro.

## Dependencies

Should work out of the box, but just in case install the following (example for alpine):

```bash
apk add openrc wget curl
```

## Installation

1. Clone repo.
2. Copy both scripts to `/etc`.
3. Modify CERNET ID and Password in `cernet-reconn.sh`.
4. `chmod u+x` both scripts.
5. Add `cernet-chk-conn.sh` to crontab. In alpine at `/var/spool/cron/crontabs/root`. Should look like this:

   ```bash
   # do daily/weekly/monthly maintenance
   # min   hour    day     month   weekday command
   */15    *       *       *       *       run-parts /etc/periodic/15min
   0       *       *       *       *       run-parts /etc/periodic/hourly
   0       2       *       *       *       run-parts /etc/periodic/daily
   0       3       *       *       6       run-parts /etc/periodic/weekly
   0       5       1       *       *       run-parts /etc/periodic/monthly

   */15     *       *       *       *       sh /etc/cernet-chk-conn.sh        # the line we add.
   ```

For OpenWRT, crontab could be modified via luci.

For other distros, just autorun `cernet-chk-conn.sh`.

## TODO

* [ ]  Improve connection test mechanism.
* [ ]  Write installation script.
* [ ]  Standardize on script location.
* [ ]  Support other login systems (maybe?)


## Disclaimer of Warranty

THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

## License

AGPL-3.0
