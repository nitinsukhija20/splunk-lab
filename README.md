
<img src="img/splunk-logo.jpg" width="300" align="right" />

# Splunk Lab

This project lets you stand up a Splunk instance in Docker on a quick and dirty basis.


## Quick Start!

Paste this in on the command line:

`bash <(curl -s https://raw.githubusercontent.com/dmuth/splunk-lab/master/go.sh)`

...and the script will print up what directory it will ingest logs from, your password, etc.  Follow the on-screen
instructions for setting environment variables and you'll be up and running in no time!  You can find your
logs with the search `index=main`.


## Screenshots

These are screenshots with actual data from production apps which I built on top of Splunk LAb:

<a href="img/bella-italia.png">
<img src="img/bella-italia.png" width="250" /></a>
<a href="img/facebook-glassdoor.png">
<img src="img/facebook-glassdoor.png" width="250" /></a>
<a href="img/pa-furry-stats.jpg">
<img src="img/pa-furry-stats.jpg" width="250" /></a>
<a href="img/network-huge-outage.png">
<img src="img/network-huge-outage.png" width="250" /></a>
<a href="img/fitbit-sleep-dashboard.png">
<img src="img/fitbit-sleep-dashboard.png" width="250" /></a>
<a href="img/snepchat-tag-cloud.jpg">
<img src="img/snepchat-tag-cloud.jpg" width="250" /></a>


## Splunk Apps Included

The following Splunk apps are included in this Docker image:

- <a href="https://splunkbase.splunk.com/app/2646/">Syndication Input</a>
- <a href="https://splunkbase.splunk.com/app/1546/">REST API Modular Input</a> (requires registration)
- <a href="https://splunkbase.splunk.com/app/3212/">Wordcloud Custom Visualization</a>
- <a href="https://splunkbase.splunk.com/app/2878/">Slack Notification Alert</a>
- <a href="https://splunkbase.splunk.com/app/2890/">Splunk Machine Learning Toolkit</a>
   - <a href="https://splunkbase.splunk.com/app/2882/">Python for Scientific Computing (for Linux 64-bit)</a>
   - <a href="https://splunkbase.splunk.com/app/4066/">NLP Text Analytics</a>
   - <a href="https://splunkbase.splunk.com/app/3514/">Halo - Custom Visualization</a>
   - <a href="https://splunkbase.splunk.com/app/3112/">Sankey Diagram - Custom Visualization</a>


All apps are covered under their own license.  Please check <a href="vendor/README.md">the Apps page</a>
for more info.

Splunk has its own license.  Please abide by it.


## Free Sources of Data

I put together this curated list of free sources of data which can be pulled into Splunk
via one of the includes apps:

- Free
    - RSS
       - <a href="https://answers.splunk.com/feed/questions.rss">Recent questions posted to Splunk Answers</a>
       - <a href="http://www.cnn.com/services/rss/">CNN RSS feeds</a>
       - <a href="https://www.flickr.com/services/feeds/docs/photos_public/">Flickr's Public feed</a>
          - <a href="https://api.flickr.com/services/feeds/photos_public.gne">Public Photos</a>
          - <a href="https://api.flickr.com/services/feeds/photos_public.gne?tags=cheetah">Public photos tagged "cheetah"</a>
    - Non-RSS
       - Non-streaming
          - <a href="http://www3.septa.org/hackathon/">Philadelphia Public Transit API</a>
             - <a href="http://www3.septa.org/hackathon/TrainView/">Regional Rail Train Data</a>
          - <a href="https://developers.coinbase.com/docs/wallet/guides/price-data">Coinbase API</a>
         - <a href="https://www.weather.gov/documentation/services-web-api">National Weather Service</a>
            - <a href="https://api.weather.gov/gridpoints/PHI/49,75/forecast">Philadelphia Forecast</a>
            - <a href="https://api.weather.gov/gridpoints/PHI/49,75/forecast/hourly">Philadelphia Hourly Forecast</a>
         - <a href="https://www.alphavantage.co/">Alpha Vantage</a> - Free stock quotes
       - Streaming
          - <a href="https://www.meetup.com/meetup_api/docs/stream/2/rsvps/">Meetup RSVPs</a>
             - <a href="http://stream.meetup.com/2/rsvps">RSVP Endpoint</a>


## Apps Built With Splunk Lab

Since building Splunk Lab, I have used it as the basis for building other projects:

- <a href="https://github.com/dmuth/SeptaStats/tree/master">SEPTA Stats</a>
   - Website with real-time stats on <a href="http://www.septa.org/service/rail/">Philadelphia Regional Rail</a>.
   - Pulled down over 60 million traind data points over 4 years using Splunk.
- <a href="https://github.com/twintproject/twint-splunk">Splunk Twint</a>
   - Splunk dashboards for Twitter timelines downloaded by Twint.  This now a part of the <a href="https://github.com/twintproject">TWINT Project</a>.
- <a href="https://github.com/dmuth/splunk-yelp-reviews">Splunk Yelp Reviews</a>
   - This project lets you pull down Yelp reviews for venues and view visualizations and wordclouds of positive/negative reviews in a Splunk dashboard.
- <a href="https://github.com/dmuth/splunk-glassdoor">Splunk Glassdoor Reviews</a>
   - Similar to Splunk Yelp, this project lets you pull down company reviews from Glassdoor and Splunk them
- <a href="https://github.com/dmuth/splunk-telegram">Splunk Telegram</a>
   - This app lets you run Splunk against messages from Telegram groups and generate graphs and word clouds based on the activity in them.
- <a href="https://github.com/dmuth/splunk-network-health-check">Splunk Network Health Check</a>
   - Pings 1 or more hosts and graphs the results in Splunk so you can monitor network connectivity over time.
- <a href="https://github.com/dmuth/splunk-fitbit">Splunk Fitbit</a>
   - Analyzes data from your Fitbit
- <a href="https://github.com/dmuth/splunk-aws-s3-server-accesslogs">Splunk for AWS S3 Server Access Logs</a>
   - App to analyize AWS S3 Access Logs


Here's all of the above, presented as a graph:

<img src="img/app-tree.png" width="500" />


## A Word About Security

HTTPS is turned on by default.  Passwords such as `password` and <a href="https://www.youtube.com/watch?v=a6iW-8xPw3k">12345</a> are not permitted.

Please, <a href="https://diceware.dmuth.org/">use a strong password</a> if you are deploying
this on a public-facing machine.


## FAQ

### Does this work on Macs?

Sure does!  I built this on a Mac. :-)


## Development

I wrote a series of helper scripts in `bin/` to make the process easier:

- `./bin/build.sh` - Build the container.
   - Note that this downloads packages from an AWS S3 bucket that I created.  This bucket is set to "requestor pays", so you'll need to make sure the `aws` CLI app set up.
- `./bin/push.sh` - Tag and push the container.
- `./bin/devel.sh` - Build and tag the container, then start it with an interactive bash shell.
   - This is a wrapper for the above-mentioned `go.sh` script. Any environment variables that work there will work here.
- `./bin/clean.sh` - Remove logs/ and/or data/ directories.


### A word on default/ and local/ directories

I had to struggle with this for awhile, so I'm mostly documenting it here.

When in devel mode, /opt/splunk/etc/apps/splunk-lab/ is mounted to `./splunk-app/` via `go.sh`
and the entrypoint script inside of the container smylinks `local/` to `default/`.
This way, any changes that are made to dashboards will be propagated outside of
the container and can be checked in to Git.

When in production mode (e.g. running `./go.sh` directly), no symlink is created,
instead `local/` is mounted by whatever `$SPLUNK_APP` is pointing to, so that any
changes made by the user will show up on their host, with Splunk Lab's `default/`
directory being untouched.


## Additional Reading

- <a href="https://github.com/dmuth/splunk-network-health-check">Splunk Network Health Check</a>


## Notes/Bugs

- The Docker containers are **dmuth1/splunk-lab** and **dmuth1/splunk-lab-ml**.  The latter has all of the Machine Learning apps built in to the image.  Feel free to extend those for your own projects.
- If I run `./bin/create-test-logfiles.sh 10000` and then start Splunk Lab on a Mac, all of the files will be Indexed without any major issues, but then the CPU will spin, and not from Splunk. 
   - After experimenting in a Vagrant instance, this appears to be due to how Docker on OS/X handles files.  Anything over a few hundred files in the `logs/` directory is probably not a good idea. For that, a Vagrant instance doing the same workload will provide far superior performance, being able to ingest 10,000 files created in the above method in maybe 10 seconds, versus taking closer to a minute in OS/X.



## Credits

- <a href="https://github.com/mhassan2/splunk-n-box">Splunk N' Box</a> - Splunk N' Box is used to create entire Splunk clusters in Docker.  It was the first actual use of Splunk I saw in Docker, and gave me the idea that hey, maybe I could run a stand-alone Splunk instance in Docker for ad-hoc data analysis!
- <a href="http://www.splunk.com/">Splunk</a>, for having such a fantastic product which is also a great example of Operational Excellence!
- <a href="http://patorjk.com/software/taag/#p=display&h=0&v=0&f=Standard&t=Splunk%20Lab">This text to ASCII art generator</a>, for the logo I used in the script.



## Contact

My email is doug.muth@gmail.com.  I am also <a href="http://twitter.com/dmuth">@dmuth on Twitter</a> 
and <a href="http://facebook.com/dmuth">Facebook</a>!


