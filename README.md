### Structurizr DSL — README

Resumo rápido  
Structurizr DSL é uma linguagem específica de domínio (DSL) para descrever modelos de arquitetura de software baseados no C4 como código. Com ela você escreve um workspace textual que define pessoas, sistemas, contêineres, componentes e relacionamentos, e a partir desse modelo gera vários diagramas em diferentes níveis de abstração.

### Instação Structurizr Docker
```bash
docker pull structurizr/lite
docker run -it --rm -p 8080:8080 -v ./model:/usr/local/structurizr structurizr/lite
```
---

### Por que usar
- Permite "modelos, não apenas diagramas": um único arquivo DSL descreve o modelo e gera múltiplas vistas (contexto, contêiner, componente) sem duplicação de informação.  
- Integração com o ecossistema JVM: é possível executar código Java/Groovy/Kotlin durante a geração do workspace para lógica avançada ou transformações.  
- Facilita versionamento e revisão em controle de código (como Git) e colaboração entre equipes.

---

### Conceitos chave
- Workspace: raiz do arquivo DSL que contém model, views e configuration.  
- Model: definição de atores (person), sistemas (softwareSystem), containers e componentes.  
- Views: definições de diagramas (systemContext, container, component etc.) que selecionam partes do modelo para exibir.  
- Identifiers: nomes/identificadores usados para referenciar elementos dentro do workspace.  
- Styles e Theme: personalização visual dos elementos e relações.  

---

### Sintaxe básica (exemplos curtos)
- Definição do workspace:
  workspace "Nome" "Descrição" { ... }
- Criar um ator:
  person p 'Usuário' 'Descrição do usuário'
- Criar um sistema e containers:
  softwareSystem s 'Sistema' 'Descrição' {
    container frontend 'Frontend' 'React' 'Interface web'
    container backend 'API' 'Node.js' 'API REST'
  }
- Views:
  systemContext s 'Contexto' { include * autolayout lr }

---

### Boas práticas
- Modelar primeiro; depois criar as views que importam para os públicos alvo.  
- Use identificadores hierárquicos e nomes curtos para facilitar referências (ex.: !identifiers hierarchical).  
- Mantenha descrições claras e objetivas e não repita informações nas views.  
- Versione o DSL no mesmo repositório do código quando possível para manter a arquitetura sincronizada com a implementação.  
- Use styles para distinguir tipos de elementos (pessoas, bancos, componentes) e melhorar legibilidade.

---

### Exemplo mínimo
workspace "Exemplo" "Descrição" {
  model {
    u = person 'Usuário' 'Interage com o sistema'
    s = softwareSystem 'App' 'Sistema de exemplo' {
      w = container 'Web' 'React' 'Frontend'
      a = container 'API' 'Node.js' 'Backend' {
        comp = component 'Auth' 'Node.js' 'Autenticação'
      }
      db = container 'DB' 'PostgreSQL' 'Banco de dados' { tags 'Database' }
    }
    u -> s.w 'Usa via navegador'
    s.w -> s.a 'Chama endpoints'
    s.a -> s.db 'Lê/Grava'
  }

  views {
    systemContext s { include * autolayout lr }
    container s { include * autolayout lr }
    component s.a { include * autolayout lr }
  }
}

---

### Ferramentas e recursos
- Documentação oficial do Structurizr DSL (guia completo de sintaxe, exemplos e cookbooks).  
- Artigos introdutórios e posts técnicos que mostram casos de uso e comparações com outras ferramentas de "diagrams as code".

---