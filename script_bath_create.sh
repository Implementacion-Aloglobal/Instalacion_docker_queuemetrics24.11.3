#!/bin/bash
JSON_FILE="$(dirname "$0")/user.json"
#JSON_FILE="$(dirname "$0")/agent.json"
#JSON_FILE="$(dirname "$0")/queue.json"
#JSON_FILE="$(dirname "$0")/outcome.json"
#JSON_FILE="$(dirname "$0")/pauses.json"

# URL del API de QueueMetrics
API_URL="http://200.1.1.215:8080/queuemetrics/user/-/jsonEditorApi.do"

# Credenciales de usuario
USER_PASS="robot:robot"

# Verificar si el archivo JSON existe
if [[ ! -f "$JSON_FILE" ]]; then
  echo "Error: El archivo JSON '$JSON_FILE' no existe."
  exit 1
fi

# Leer el archivo JSON y enviar cada registro a la API
jq -c '.[]' "$JSON_FILE" | while read -r item; do
  echo "Enviando: $item"
  curl --user $USER_PASS -i -H "Content-Type: application/json" -X POST -d "$item" "$API_URL"
  echo "\n"
done

