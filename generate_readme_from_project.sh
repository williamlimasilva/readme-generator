#!/bin/bash

# Verificar se foi passado o diretório do projeto
if [ -z "$1" ]; then
    echo "Uso: $0 <caminho_do_projeto>"
    exit 1
fi

PROJECT_DIR=$1
README_PATH="$PROJECT_DIR/README.md"

# Verificar se o diretório existe
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Erro: O diretório especificado não existe."
    exit 1
fi

echo "Gerando README.md para o projeto em: $PROJECT_DIR"

# Identificar o nome do projeto
PROJECT_NAME=$(basename "$PROJECT_DIR")

# Inicializar variáveis
VENV_STATUS="Não"
LIBRARIES="Nenhuma biblioteca identificada"

# Verificar a existência de ambiente virtual
if [ -d "$PROJECT_DIR/venv" ] && [ -f "$PROJECT_DIR/venv/bin/python" ]; then
    VENV_STATUS="Sim (diretório venv encontrado)"
    LIBRARIES=$("$PROJECT_DIR/venv/bin/python" -m pip list --format=freeze | cut -d= -f1 | grep -v "pkg-resources")
elif [ -f "$PROJECT_DIR/requirements.txt" ]; then
    VENV_STATUS="Não (usando requirements.txt)"
    LIBRARIES=$(cat "$PROJECT_DIR/requirements.txt")
fi

# Separar pastas e arquivos da raiz em ordem alfabética
DIRS=$(find "$PROJECT_DIR" -mindepth 1 -maxdepth 1 -type d | grep -Ev "venv|__pycache__|\.git" | xargs -n 1 basename | sort)
FILES=$(find "$PROJECT_DIR" -mindepth 1 -maxdepth 1 -type f | grep -Ev "venv|__pycache__|\.git" | xargs -n 1 basename | sort)

# Criar estrutura de árvore no estilo visual da imagem fornecida
TREE=$(echo "$DIRS" | awk '{print "├── " $0}'; echo "$FILES" | awk '{print "├── " $0}')

# Gerar o README.md
cat <<EOL > "$README_PATH"
# 🗂️ Projeto: $PROJECT_NAME

![Logo do Projeto](https://via.placeholder.com/800x200?text=Imagem+do+Projeto)

## 📝 Descrição

Este projeto foi analisado automaticamente pelo script e contém as seguintes configurações e informações. Ele tem como objetivo principal **(Descrever o objetivo principal)**.

## 🎯 Objetivo do Projeto

O objetivo principal deste projeto é **descrever o objetivo aqui**.

## 🚀 Funcionalidades

- **Funcionalidade 1:** Descrever a funcionalidade aqui.
- **Funcionalidade 2:** Melhorar integração com sistemas externos.
- **Funcionalidade 3:** Adicionar suporte para novas métricas.

## 📂 Estrutura do Projeto

Abaixo está uma visualização da estrutura do projeto (pastas primeiro, seguidas de arquivos):

$TREE

## 🏆 Benefícios do Simulador

- **Precisão:** Elimina erros manuais em cálculos financeiros.
- **Eficiência:** Automatiza análises complexas, economizando tempo.
- **Clareza:** Gera relatórios detalhados que auxiliam na tomada de decisões.

## 🖥️ Como Executar

1. Clone o repositório:

   git clone <https://github.com/seuusuario/$PROJECT_NAME.git>

2. Navegue até o diretório do projeto:

   cd $PROJECT_NAME

3. Configure o ambiente virtual (se necessário):

   python3 -m venv venv
   source venv/bin/activate

4. Instale as dependências:

   pip install -r requirements.txt

5. Execute o programa principal:

   python src/main.py

## 💻 Ambiente Virtual

Ambiente virtual configurado: **$VENV_STATUS**

## 📦 Bibliotecas Utilizadas

As bibliotecas identificadas no projeto são:

$LIBRARIES

## 🚀 Tecnologias Utilizadas

As principais tecnologias utilizadas no projeto incluem:

- [Python]<https://www.python.org/>
- Outras tecnologias podem ser descritas aqui.

## 🛠️ Tarefas

- [ ] Implementar validações adicionais.
- [x] Criar interface para usuários.
- [ ] Melhorar documentação.

## 🗂️ Histórico de Lançamento

- **0.2.0**
  - MUDANÇA: Remover função antiga
  - ADICIONAR: Implementar init()
- **0.1.1**
  - CORREÇÃO: Resolver travamento ao executar foo()
- **0.1.0**
  - MUDANÇA: Refatorar foo() para bar()
- **0.0.1**
  - Inicializar o projeto

## 🤝 Contribuições

Feedbacks e sugestões são sempre bem-vindos! Sinta-se à vontade para abrir [**issues**]<https://github.com/IOVASCON/projeto/issues> ou enviar [**pull requests**]<https://github.com/IOVASCON/projeto/pulls>.

Espero que este README seja útil para explicar o projeto e atrair atenção de colaboradores e usuários. Se precisar de ajustes ou personalizações, é só avisar! 🚀

## 👥 Autor

- [@iovascon]<https://github.com/IOVASCON>

## 📜 Licença

Este projeto está sob a licença [MIT]<https://opensource.org/licenses/MIT>.
EOL

echo "README.md gerado com sucesso em: $README_PATH"
