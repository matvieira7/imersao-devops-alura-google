FROM python:3.11-slim

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# A instalação das dependências só será executada novamente se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências da aplicação
# --no-cache-dir: Desabilita o cache do pip para manter a imagem menor
# --upgrade pip: Garante que estamos usando a versão mais recente do pip
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
