# Use uma imagem base oficial do Python.
# python:3.11-slim é uma boa escolha por ser leve.
FROM python:3.11-slim

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Copiamos este arquivo separadamente para aproveitar o cache do Docker.
COPY requirements.txt .

# Instala as dependências do projeto.
# A flag --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner.
EXPOSE 8000

# Comando para iniciar a aplicação usando o servidor Uvicorn.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]