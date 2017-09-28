Changelog
=========

2.7.3 (2017-09-11)
------------------
- Use the full dotted path for the database driver name in the docker-compose file.
- Use Mayan EDMS version 2.7.3

2.7.2 (2017-09-06)
------------------
- Use Mayan EDMS version 2.7.2

2.7.1 (2017-09-03)
------------------
- Fix typo in README. GitLab issue #12. Tnanks to Tobias Mersmann (@tmerse)
  for the find.
- Remove shorthand support for the Django database driver name.

2.6.4-4 (2017-07-28)
--------------------
- Rename the variable MAYAN_SETTINGS_LOCAL to MAYAN_SETTINGS_LOCAL_STRING
- Add a new variable called MAYAN_SETTINGS_LOCAL_FILE.

2.6.4-3 (2017-07-26)
--------------------
- Use printf instead of echo to support newlines.

2.6.4-2 (2017-07-26)
--------------------
- Add Makefile with targets to generate README.md file, build images and make
  releases.
- Add support for generating the settings/local.py file from the environment
  variable: MAYAN_SETTINGS_LOCAL.

2.6.4-1 (2017-07-25)
--------------------
- Perform APT and PIP installs always.

2.6.4 (2017-07-25)
------------------
- Update to Mayan EDMS version 2.6.4.
- Don't overwrite existing local.py during initialization.

2.6.3 (2017-07-25)
------------------
- Update to Mayan EDMS version 2.6.3.

2.6.2 (2017-07-22)
------------------
- Update to Mayan EDMS version 2.6.2.

2.6.1 (2017-07-18)
------------------
- Update to Mayan EDMS version 2.6.1.

2.6 (2017-07-18)
----------------
- Update to Mayan EDMS version 2.6.

2.5.2 (2017-07-08)
------------------
- Update to Mayan EDMS version 2.5.2.

2.5.1 (2017-07-07)
------------------
- Update to Mayan EDMS version 2.5.1.
- Add Add collectstatic step to the upgrade() function. GitLab issue #11.
- Add the new 'documents' queue to the medium worker.
- Allow setting NGINX's client_max_body_size and proxy_read_timeout
  from environment variables.
- Add instruction on mounting host data for watched folders or staging folders.
  GitLab issue #2.
- Error logging improvements.

2.4 (2017-06-26)
----------------
- Allow changing the database backend.
- Allow changing the Celery broker.
- Allow changing the Celery results backend.
- Add a dedicated image converter worker.
- Implement single installation step.
- Implement single volume solution.
- Increase NGINX max file size to 500 MB.
- Increase NGINX file transfer timeout to 600 seconds.
- When overrided, the database settings will add the option to keep connections
  alive with a default of 60 seconds. ('CONN_MAX_AGE': 60)

New environment variables:

- MAYAN_DATABASE_DRIVER, default: None
- MAYAN_DATABASE_NAME, default : 'mayan'
- MAYAN_DATABASE_USER, default: 'mayan'
- MAYAN_DATABASE_PASSWORD, default: ''
- MAYAN_DATABASE_HOST, default: None
- MAYAN_DATABASE_PORT, default: None
- MAYAN_BROKER_URL, default: 'redis://127.0.0.1:6379/0'
- MAYAN_CELERY_RESULT_BACKEND, default: 'redis://127.0.0.1:6379/0'

- If the MAYAN_BROKER_URL and MAYAN_CELERY_RESULT_BACKEND are specified the built in
  REDIS server is disabled.
- Add health check.
- Add production and development Docker compose files.
- Update to Mayan EDMS 2.4.

2.1.10 (2017-02-25)
-------------------
- Update to Mayan EDMS 2.1.10.
- Add upgrade instructions.
- Add customization instructions.

2017-01-06
----------
- Add Vagrantfile to build and test Docker image.

2.1.6 (2016-11-23)
------------------
- Update to Mayan EDMS version 2.1.6.
- Add HISTORY.md file.

