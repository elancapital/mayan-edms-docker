from __future__ import unicode_literals

from django.apps import apps
from django.utils.encoding import force_text
from django.utils.log import configure_logging

import logging

ALLOWED_HOSTS = ['*']

# The callable to use to configure logging
LOGGING_CONFIG = 'logging.config.dictConfig'

# Custom logging configuration.
LOGGING = {}

configure_logging(LOGGING_CONFIG, LOGGING)

logging.config.dictConfig(
    {
        'version': 1,
        'disable_existing_loggers': True,
        'formatters': {
            'intermediate': {
                'format': '%(name)s <%(process)d> [%(levelname)s] "%(funcName)s() %(message)s"'
            },
        },
        'handlers': {
            'console': {
                'level': 'DEBUG',
                'class': 'logging.StreamHandler',
                'formatter': 'intermediate'
            }
        },
        'loggers': {
            'mayan': {
                'handlers': ['console'],
                'propagate': True,
                'level': 'INFO',
            }
        }
    }
)
logger = logging.getLogger(__name__)

try:
    from mayan.media.settings.local import *  # NOQA
except ImportError as exception:
    if force_text(exception).endswith('No module named local'):
        # <module>() exception "No module named local"
        logger.info('No local.py settings file. Using defaults.')
    else:
        logger.error('Error importing user\'s local.py; %s', exception)

    from .docker import *  # NOQA
except Exception as exception:
    logger.error('Error importing user\'s local.py; %s', exception)
    raise
else:
    logger.info('Good local.py found. Using user settings.')
