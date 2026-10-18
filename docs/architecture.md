# Test architecture
Layer first, business domain second. Catalogue owns specification; tests own automation; reports own immutable execution evidence. data/models owns matrix dimensions; generator owns deterministic expansion; generated holds derived read-only data. Keep schemas beside the catalogue. Unit/component tests stay with product code in frontend/backend repos. OpenTofu lives in brekmate-infra, not this repo.

Folders are created only for useful files. Add API/integration/security/accessibility/resilience/performance runner folders as actual implementations arrive. No empty placeholder forest or fabricated app tests.

Existing feature files and generated/catalogue.csv are views, not competing editable sources. No Cucumber dependency has been added. No cloud resources or paid runners are required to validate the catalogue and generators. JSON schema documents use an explicitly validated subset; scripts/schema-validator.mjs rejects unsupported keywords rather than claiming full standards compliance.
