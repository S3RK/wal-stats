*IMPORTANT* Those scripts has not been writen with reuse/extension in mind.
Use on your own risk.

Couple scripts to collect listing of WAL files from postgres.

wals.sh — dump listing of pg_xlog dir into file. Supposed to be run via cron
load.sh — load files gathered by `wals.sh` into DB for future analysis

# How to
1. Run wals.sh via cron on host where kubectl is configured
2. Copy gathered files to working directory
3. Run `load.sh` to start new postgres container and load all data into it
4. Observe data in `test.wals` table
