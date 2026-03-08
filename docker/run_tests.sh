#!/bin/bash
set -e
ADDONS_PATH="/mnt/extra-addons"
TEST_LOG="/var/log/odoo/test.log"
echo "🔍 Discovering modules with tests in ${ADDONS_PATH}..."
MODULES=""
while IFS= read -r testdir; do
  if ls "${testdir}"/test_*.py 2>/dev/null | grep -q .; then
    MODULE_NAME=$(basename "$(dirname "${testdir}")")
    echo "  📦 ${MODULE_NAME}"
    MODULES="${MODULES:+${MODULES},}${MODULE_NAME}"
  fi
done < <(find "${ADDONS_PATH}" -type d -name "tests" | sort)

if [ -z "$MODULES" ]; then echo "⚠️  No testable modules found. Skipping."; exit 0; fi
echo "✅ Testing: ${MODULES}"

python /usr/bin/odoo --test-enable --test-tags "/" --stop-after-init --no-http \
  -d "${DB_NAME}" -r "${DB_USER}" -w "${DB_PASSWORD}" \
  --db_host "${DB_HOST}" --db_port "${DB_PORT:-5432}" \
  --addons-path="/usr/lib/python3/dist-packages/odoo/addons,${ADDONS_PATH}" \
  -u "${MODULES}" --log-level=test 2>&1 | tee "${TEST_LOG}"

EXIT_CODE=${PIPESTATUS[0]}
FAILED=$(grep -c "FAIL\|ERROR\|AssertionError" "${TEST_LOG}" 2>/dev/null || true)
if [ "$EXIT_CODE" -ne 0 ] || [ "$FAILED" -gt 0 ]; then
  echo "❌ TESTS FAILED. See ${TEST_LOG}"; exit 1
fi
echo "✅ All tests passed."
