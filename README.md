#CUPeru
[![Build Status](https://travis-ci.org/CUPeru/CUPeru.svg?branch=master)](https://travis-ci.org/CUPeru/CUPeru)[![Coverage Status](https://coveralls.io/repos/CUPeru/CUPeru/badge.svg?branch=master&service=github)](https://coveralls.io/github/CUPeru/CUPeru?branch=master)

A SMS-based group communication app to coordinate medical efforts for
[Comunidades Unidas Peru].

Requirements
------------

- Ruby 2.2.2
- Postgresql
- Redis
- Bundler

Local installation
------------------

```
git clone git@github.com:CUPeru/CUPeru.git
cd CUPeru
bundle install
rake db:create
rake db:schema:load
```

Configuration
-------------

This app requires API credentials for both [Twilio] and [Twitter]. These go in the
`config/application.yml` file. There's an `application.yml.sample` file in the
same directory with appropriate key names.

The callback url for the Twitter API must be set to
`<root url>/auth/twitter/callback`.


Deploying to Heroku
-------------------

[Heroku] setup requires the same configuration variables to be set as in the
`application.yml` file. These can be set online or through `heroku config`.

To Do
-----

- Fix automatic message retrieval
- Write CONTRIBUTING.md
- Localize messages
- Shore up integration tests:
  - User creation via SMS
  - Sending messages via web interface
- Style guide compliance
- Add code of conduct
- File issues
- Unify sender models
- Replace Twitter auth with a full Devise install (to screen viewers)
- Rework front end:
  - Refactor the dashboard
  - Show live updates to messages
  - React project?
- New actions:
  - Autoforwarding
  - Autoreply
  - Username messaging
  - Broadcasts (to all users and to groups)
