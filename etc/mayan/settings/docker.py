from __future__ import unicode_literals

import os

from mayan.settings.base import *

mayan_environment_database_driver = os.environ.get('MAYAN_DATABASE_DRIVER')

# If the MAYAN_DATABASE_DRIVER environment variable is set that means the user
# wants to override the default driver. See if the user supplied a shorthand
# name otherwise use the full value passed in the environment variable.

if mayan_environment_database_driver:
    DATABASES = {
        'default': {
            'ENGINE': mayan_environment_database_driver,
            'NAME': os.environ.get('MAYAN_DATABASE_NAME', 'mayan'),
            'USER': os.environ.get('MAYAN_DATABASE_USER', 'mayan'),
            'PASSWORD': os.environ.get('MAYAN_DATABASE_PASSWORD', ''),
            'HOST': os.environ.get('MAYAN_DATABASE_HOST', None),
            'PORT': os.environ.get('MAYAN_DATABASE_PORT', None),
            'CONN_MAX_AGE': 60,
        }
    }

BROKER_URL = os.environ.get(
    'MAYAN_BROKER_URL', 'redis://127.0.0.1:6379/0'
)
CELERY_RESULT_BACKEND = os.environ.get(
    'MAYAN_CELERY_RESULT_BACKEND', 'redis://127.0.0.1:6379/0'
)
