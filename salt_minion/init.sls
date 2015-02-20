{%- from 'salt_minion/map.jinja' import salt_minion with context -%}

salt_minion_pkg:
  pkg.installed:
    - name: {{ salt_minion.pkg }}
{%- if 'version' in salt_minion %}
    - version: {{ salt_minion.version }}
{%- endif %}

# Set value for master
salt_minion_master:
  file.replace:
    - name: {{ salt_minion.conf_path }}
    - pattern: '^master=.*'
    - repl: "master={{ salt_minion.master }}"
    - require:
      - pkg: salt_minion_pkg
    - unless:
      - grep "master={{ salt_minion.master }}" {{ salt_minion.conf_path }}
    - watch_in:
      - service: salt_minion_service

salt_minion_master_commented:
  file.replace:
    - name: {{ salt_minion.conf_path }}
    - pattern: '^#master=.*'
    - repl: "allowed_hosts={{ salt_minion.master }}"
    - require:
      - pkg: salt_minion_pkg
    - unless:
      - grep "allowed_hosts={{ salt_minion.master }}" {{ salt_minion.conf_path }}
    - watch_in:
      - service: salt_minion_service

salt_minion_service:
  service.running:
    - name: {{ salt_minion.service }}
    - enable: {{ salt_minion.enabled }}
    - reload: False
    - watch:
      - pkg: salt_minion_pkg
