CUPeru
======

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
