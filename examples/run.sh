#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_tentacle info
PYTHONPATH=src python -m gbt_tentacle check --payload '{"action": "<在此填写>"}'
PYTHONPATH=src python -m gbt_tentacle run   --payload '{"action": "<在此填写>"}'
