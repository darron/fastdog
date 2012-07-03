Fastly CDN -> syslog -> DogStatsd -> DatadogHQ
==============================================

I wanted to view my Fastly stats inside of my Datadog dashboard - here's how it's done:

Pre-requisites
--------------

1. [Fastly CDN](http://www.fastly.com/) account at the "Faster" level.
2. A [DatadogHQ](http://www.datadoghq.com/) account.
3. An Ubuntu 10.0.4LTS server with Syslog port open.
4. [Datadog software higher than 3.0.x](http://api.datadoghq.com/guides/dogstatsd/) installed on that machine.
5. If you use Chef - [there's a cookbook that can help.](chef/cookbook)

To setup
--------

1. Fastly Syslog targeting.
2. Deploy your updated VCL files.
3. apt-get install libcurl4-openssl-dev
4. gem install fastly dogstatsd-ruby statsd dogapi eventmachine eventmachinetail
5. Wait for the logs to run in.
6. Pick a log - I used /var/log/user.log
7. Run the fastlog.rb script like this: ruby fastdog.rb /var/log/user.log
8. Profit.