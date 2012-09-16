module.exports =
  mongodb:
    development:
      name: 'skill-up-development'
      port: 27017
      host: '127.0.0.1'
    test:
      name: 'skill-up-test'
      port: 27017
      host: '127.0.0.1'
    staging:
      name: 'skill-up-staging'
      port: 27017
      host: '127.0.0.1'
    production:
      name: 'skill-up-production'
      port: 27017
      host: '127.0.0.1'

  redis:
    development:
      name: 'skill-up-development'
      port: 6397
      host: '127.0.0.1'
    test:
      name: 'skill-up-test'
      port: 6397
      host: '127.0.0.1'
    staging:
      name: 'skill-up-staging'
      port: 6397
      host: '127.0.0.1'
    production:
      name: 'skill-up-production'
      port: 6397
      host: '127.0.0.1'
