# Authoritative specification
`scenarios/*.json` is authoritative. Stable BM-* IDs are preserved from the initial package. `requirements/areas.json` contains requirement-area groupings; detailed rules are in docs/confirmed-requirements.md. These area IDs are not claims that every fine-grained requirement has been enumerated.

Readable feature files are generated from the catalogue; edit the JSON and regenerate. CSV is generated for filtering. Immutable execution records are stored separately under reports/runs. No scenario is marked passed by its presence here. The complete inventory intentionally includes open-decision cases.
