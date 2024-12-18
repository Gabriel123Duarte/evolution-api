#!/bin/bash

# Validar se as variáveis essenciais estão disponíveis
if [ -z "$PGHOST" ] || [ -z "$PGUSER" ] || [ -z "$PGPASSWORD" ] || [ -z "$PGDATABASE" ]; then
  echo "Erro: Variáveis do PostgreSQL não configuradas no .env."
  exit 1
fi

# Criar a string de conexão do banco de dados
export DATABASE_CONNECTION_URI="postgresql://$PGUSER:$PGPASSWORD@$PGHOST:$PGPORT/$PGDATABASE"

# Verificar conexão com o banco antes de iniciar a API
until pg_isready -h $PGHOST -p $PGPORT -U $PGUSER; do
  echo "Aguardando PostgreSQL..."
  sleep 2
done

echo "PostgreSQL disponível! Iniciando a API Evolution..."

# Iniciar a API Evolution
npm run start:prod