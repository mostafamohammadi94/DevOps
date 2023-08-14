python-docker:
  pkg.installed:
    - name: docker-compose



/app/docker-compose.yml:
  file.managed:
    - source: salt://prometheus/dockerfiles/docker-compose.yml


/app/prometheus/prometheus.yml:
  file.managed:
    - name: /app/prometheus/prometheus.yml
    - source: salt://prometheus/conf.d/prometheus.yml


docker-compose-up:
  cmd.run:
    - name: docker-compose -f /app/docker-compose.yml up -d
    - failhard: True
    - watch:
      - file: /app/docker-compose.yml

reload-configs:
  cmd.run:
    - name: curl -L -v  -X POST http://185.3.125.10:9090/-/reload


### saltstack configuration file ###
