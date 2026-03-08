#!/bin/bash
set -e
echo "============================================"
echo "  Odoo Kubernetes — Odoo.sh-like Lifecycle  "
echo "============================================"

echo "▶️  [1/4] pre-start: Waiting for PostgreSQL at ${DB_HOST}:${DB_PORT:-5432}..."
RETRIES=30
until pg_isready -h "${DB_HOST}" -p "${DB_PORT:-5432}" -U "${DB_USER}" -q; do
  RETRIES=$((RETRIES - 1))
  if [ "$RETRIES" -le 0 ]; then echo "❌ PostgreSQL not ready. Exiting."; exit 1; fi
  echo "   Retrying in 3s... (${RETRIES} left)"
  sleep 3
done
echo "✅ PostgreSQL is ready."

echo "▶️  [2/4] migrate: Running DB migrations (-u all)..."
python /usr/bin/odoo --stop-after-init --no-http \
  -d "${DB_NAME}" -r "${DB_USER}" -w "${DB_PASSWORD}" \
  --db_host "${DB_HOST}" --db_port "${DB_PORT:-5432}" \
  --addons-path="/usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons" \
  -u all --log-level=warn
echo "✅ Migrations complete."

if [ "${TEST_ENABLE:-false}" = "true" ]; then
  echo "▶️  [3/4] test: Running automated tests..."
  /run_tests.sh
  echo "✅ All tests passed."
else
  echo "⏭️  [3/4] test: Skipping (TEST_ENABLE=false)."
fi

echo "▶️  [4/4] start: Launching Odoo server..."
exec python /usr/bin/odoo -c /etc/odoo/odoo.conf \
  -d "${DB_NAME}" -r "${DB_USER}" -w "${DB_PASSWORD}" \
  --db_host "${DB_HOST}" --db_port "${DB_PORT:-5432}" "$@"
