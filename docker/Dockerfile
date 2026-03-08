FROM odoo:17.0
USER root
RUN apt-get update && apt-get install -y --no-install-recommends postgresql-client && rm -rf /var/lib/apt/lists/*
COPY ./custom_addons /mnt/extra-addons
COPY ./docker/odoo.conf    /etc/odoo/odoo.conf
COPY ./docker/entrypoint.sh /entrypoint.sh
COPY ./docker/run_tests.sh  /run_tests.sh
RUN mkdir -p /var/log/odoo \
    && chown -R odoo:odoo /var/log/odoo /mnt/extra-addons /etc/odoo/odoo.conf \
    && chmod +x /entrypoint.sh /run_tests.sh
USER odoo
ENTRYPOINT ["/entrypoint.sh"]
