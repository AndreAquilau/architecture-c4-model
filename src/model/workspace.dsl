workspace "Sistema CRUD de Usuários" "Modelo C4 para um sistema CRUD de usuários com frontend React, backend Node.js e banco de dados" {

    !identifiers hierarchical

    model {
        usuario = person "Usuário" "Pessoa que usa a aplicação para registrar, autenticar e gerenciar contas de usuário"

        sistema = softwareSystem "Sistema de Gerenciamento de Usuários" "Fornece funcionalidades de login, logout, cadastro, consulta, atualização e exclusão de usuários" {
            frontend = container "Frontend React" "React (JavaScript/TypeScript)" "Interface web para login, cadastro, listagem, edição e remoção de usuários"
            backend = container "API Node.js" "Node.js (Express ou similar)" "API REST que expõe endpoints de autenticação e CRUD de usuários" {
                // Componentes do backend (definidos dentro do container backend)
                authController = component "Controlador de Autenticação" "Node.js" "Endpoints: POST /login; POST /logout; POST /register"
                userController = component "Controlador de Usuário" "Node.js" "Endpoints: GET /users; GET /users?name=; GET /users/{id}; POST /users; PUT /users/{id}; DELETE /users/{id}"
                userService = component "Serviço de Usuário" "Node.js" "Regras de negócio: validação; hashing de senha; autorização"
                userRepository = component "Repositório de Usuário" "Node.js" "Acesso ao banco: consultas; inserções; atualizações; exclusões"
            }
            banco = container "Banco de Dados de Usuários" "PostgreSQL" "Armazena usuários, senhas (hash), tokens de sessão e perfil" {
                tags "Database"
            }
        }

        usuario -> sistema.frontend "Acessa via navegador"
        sistema.frontend -> sistema.backend "Requisições HTTP/HTTPS (login, logout, CRUD)"
        sistema.backend -> sistema.banco "Lê e grava dados de usuários"

        sistema.backend.authController -> sistema.backend.userService "Usa para verificação e criação de sessão"
        sistema.backend.userController -> sistema.backend.userService "Usa"
        sistema.backend.userService -> sistema.backend.userRepository "Usa"
        sistema.backend.userRepository -> sistema.banco "Lê e escreve"
    }

    views {
        systemContext sistema "ContextoSistema" {
            include *
            autolayout lr
        }

        container sistema "Conteineres" {
            include *
            autolayout lr
        }

        component sistema.backend "ComponentesBackend" {
            include *
            autolayout lr
        }

        styles {
            element "Element" {
                color #23A5D9
                stroke #2387D9
                strokeWidth 7
                shape roundedbox
            }
            element "Person" {
                shape person
            }
            element "Database" {
                shape cylinder
            }
            element "Boundary" {
                strokeWidth 5
            }
            relationship "Relationship" {
                thickness 4
            }
            element "Container" {
                background #F3F7FA
                stroke #2387D9
            }
            element "Component" {
                background #FFFFFF
                stroke #2B9FD4
            }
        }
    }

    configuration {
        scope softwaresystem
    }
}
