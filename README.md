Fastly CDN -> syslog -> DogStatsd -> DatadogHQ
==============================================

I wanted to view my Fastly stats inside of my Datadog dashboard - here's how it's done:

Pre-requisites
--------------

1. [Fastly CDN](http://www.fastly.com/) account at the "Faster" level.
2. A [DatadogHQ](http://www.datadoghq.com/) account.
3. An Ubuntu 10.0.4LTS server with Syslog TCP port open.
4. [Datadog software higher than 3.0.x](http://api.datadoghq.com/guides/dogstatsd/) installed on that machine.
5. If you use Chef - [there's a cookbook that can help.](https://github.com/darron/fastdog/tree/master/chef/cookbook)

To setup
--------

1. [You need to tell Fastly where to push the logfiles.](https://github.com/darron/fastdog/blob/master/fastly.rb) - you may also be able to do this from the [Fastly admin interface](http://app.fastly.com).
2. Deploy your updated VCL files - from within the [Fastly admin interface](http://app.fastly.com).
3. On the Ubuntu box: `apt-get install libcurl4-openssl-dev`
4. On the Ubuntu box: `gem install fastly dogstatsd-ruby statsd dogapi eventmachine eventmachinetail`
5. Wait for the logs to show up - it was pretty quick for me.
6. Pick a log where the data's appearing - I used /var/log/user.log.
7. Run the [fastdog.rb](https://github.com/darron/fastdog/blob/master/fastdog.rb) script like this: `ruby fastdog.rb /var/log/user.log`
8. In the [Datadog admin interface](http://app.datadoghq.com) - create a [new graph like this](https://github.com/darron/fastdog/blob/master/datadog-metrics.png).
9. Profit.

![Profit](https://github.com/darron/fastdog/raw/master/result.png).

To do
-----

1. Count hits for specific sites as required.
2. Add bytes graph. For specific sites as required.
3. Daemonize [fastdog.rb](https://github.com/darron/fastdog/blob/master/fastdog.rb) - right now it's running in screen - sue me.