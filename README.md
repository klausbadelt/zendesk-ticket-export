# Download Zendesk tickets to csv

## Name

    all-tickets.rb
    open-tickets.rb


## Description

These little scripts download all / all open Zendesk tickets to csv. It uses the official Zendesk APIs for Search and Tickets, and the official Zendesk API Ruby Gem.

* `all-tickets.rb` exports *all* tickets into `all-tickets.csv`
* `open-tickets.rb` export all *non-solved* tickets into `open-tickets.csv`

The csv columns include all comments of each ticket, i.e. the full "thread", and the following columns:

* Comment date
* Ticket ID
* From email
* Comment
* Ticket date
* Ticket subject,
* Ticket description,
* Ticket status,
* Original ticket channel (web, email etc)
* All tags, separated by `|`

Note this is not meant to be a complete, configurable, all-purpose Zendesk export utility. It did it's specific job for us at [Filmhub](https://filmhub.com), and at best I'm hoping this to be some useful snippets on how to use the Zendesk API and Zendesk Ruby gem.

## Installation

You'll need Ruby 2.5+ and bundler.

```sh
bundle install
```

## Configuration

Set your Zendesk username and password in environment variables `ZENDESK_USERNAME` and `ZENDESK_PASSWORD`, respectively.

## Synopsis

```sh
ZENDESK_USERNAME=[your username] ZENDESK_PASSWORD=[your password] ruby open-tickets.rb
```

```sh
ZENDESK_USERNAME=[your username] ZENDESK_PASSWORD=[your password] ruby all-tickets.rb
```

Progress output:

    Exporting 1458 tickets
    9 Tickets imported...

## Issues

We hit the Zendesk API rate limiting very fast. Sideloading of comments with tickets is not supported by Zendesk, thus there are roughly as many API calls  needed as there are tickets. In addition, Zendesk limits page results to 100, requiring more calls per page. With a higher level (i.e. more expensive) Zendesk plan your mileage might increase.

This utility though does handle rate limiting though. It waits the exact seconds until the next API call can be made. With our Zendesk plan, about 10 tickets per minute could be exported. With hundreds or thousands of tickets, prepare to spend a few hours or more waiting for the export to finish.

## Todo

* tests
* documentation

