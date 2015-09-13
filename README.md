# Munin (master)

## Quickstart
Munin stats aggregator and reporting

* `docker build -t munin .`
or
* `docker pull lrivallain/munin`

then
* `docker run -p 80 munin`

With a node list:
* `docker run -p 80 -e NODES="foo.local:127.0.0.1 bar.remote:1.2.3.4" munin`

## How it works
### Ports
* 80

### Volumes
* `/var/lib/munin` : Databases files
* `/var/log/munin` : Logs
* `/var/cache/munin` : Where are generated graphs

### Environment Variables
* `NODES`: Space separated list of `<name>:<host>` munin node pairs. (i.e. `foo.local:127.0.0.1 bar.remote:1.2.3.4`)
* `CRONDELAY`: Change the cron settings to update charts every X minutes (default: 2)
* `TZ`: Customize the timezone according to your place: (i.e. `Europe/London`) (default: `Europe/Paris`)
* `THISNODENAME`: Customize the displayed node name for localhost.localdomain (default: `munin`) 

## Persistent example
	docker run \
	 -d --rm \
	 --name=munin \
	 -p 127.0.0.1:8080:80 \
	 -e THISNODENAME="munin.example.com" \
	 -e TZ="Europe/London" \
	 -e CRONDELAY=2 \
	 -e NODES="anothernode.example.com:1.2.3.4 anothernode2.example.com:5.6.7.8" \
	 -v /data/munin/db:/var/lib/munin \
	 -v /data/munin/logs:/var/log/munin \
	 -v /data/munin/cache:/var/cache/munin \
	 munin
`
