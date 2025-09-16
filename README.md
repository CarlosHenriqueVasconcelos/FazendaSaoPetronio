# BEGO Agritech Desktop - Flutter

Sistema de Gestão Pecuária para Desktop desenvolvido em Flutter, focado no gerenciamento offline de ovinos e caprinos.

## 🚀 Funcionalidades Implementadas

### ✅ Dashboard Principal
- **Estatísticas em tempo real**: Total de animais, saudáveis, gestantes e receita mensal
- **Alertas importantes**: Vacinações pendentes, partos previstos
- **Ações rápidas**: Registrar nascimentos, agendar vacinações, movimentar animais
- **Grid de animais**: Visualização completa do rebanho com filtros

### ✅ Cards de Animais
- **Informações detalhadas**: ID, nome, espécie, raça, idade, peso, localização
- **Status visuais**: Saudável, em tratamento, reprodutor
- **Indicadores especiais**: Gestação, problemas de saúde
- **Ações**: Ver histórico, editar dados

### ✅ Sistema de Design
- **Tema rural/natureza**: Cores verdes, marrons e douradas
- **Modo claro/escuro**: Adaptação automática ao sistema
- **Componentes responsivos**: Layout adaptável para desktop
- **Ícones intuitivos**: Interface amigável para produtores rurais

## 🎯 Dados Offline

O sistema funciona completamente offline com dados mockados, incluindo:
- **3 animais exemplo**: Benedita (ovino gestante), Joaquim (caprino reprodutor), Esperança (ovino em tratamento)
- **Estatísticas simuladas**: 45 animais totais, métricas de saúde e produtividade
- **Alertas automáticos**: Baseados nos dados dos animais

## 🛠️ Tecnologias Utilizadas

- **Flutter 3.0+**: Framework multiplataforma
- **Provider**: Gerenciamento de estado
- **Material Design 3**: Sistema de design moderno
- **Intl**: Formatação de datas e números (pt-BR)

## 📱 Executar o Projeto

### Pré-requisitos
- Flutter SDK 3.0 ou superior
- Dart SDK
- IDE (VS Code, Android Studio)

### Comandos

```bash
# Navegar para o diretório do projeto
cd flutter_desktop

# Instalar dependências
flutter pub get

# Executar no desktop
flutter run -d windows    # Windows
flutter run -d macos      # macOS  
flutter run -d linux      # Linux

# Build para produção
flutter build windows     # Windows
flutter build macos       # macOS
flutter build linux       # Linux
```

## 📦 Estrutura do Projeto

```
flutter_desktop/
├── lib/
│   ├── main.dart                 # Ponto de entrada
│   ├── models/
│   │   └── animal.dart           # Modelo de dados dos animais
│   ├── services/
│   │   └── animal_service.dart   # Serviço com dados mockados
│   ├── screens/
│   │   └── dashboard_screen.dart # Tela principal do dashboard
│   ├── widgets/
│   │   ├── animal_card.dart      # Card individual do animal
│   │   ├── stats_card.dart       # Card de estatísticas
│   │   └── alert_card.dart       # Card de alertas
│   └── theme/
│       └── app_theme.dart        # Tema e cores do app
├── pubspec.yaml                  # Dependências e configurações
└── README.md                     # Este arquivo
```

## 🔄 Próximos Passos

1. **Integração com Supabase**: Conectar com banco de dados online
2. **Sincronização**: Sistema de sync offline/online
3. **Autenticação**: Login de usuários
4. **Cadastro de animais**: Formulários completos
5. **Relatórios**: Gráficos e exportação de dados
6. **Fotos**: Upload e visualização de imagens dos animais
7. **QR Codes**: Identificação rápida dos animais

## 📋 Recursos Adicionais

- **Funcionamento offline completo**
- **Interface otimizada para desktop**
- **Tema rural com cores naturais**
- **Dados realistas para testes**
- **Arquitetura escalável e modular**

---

**BEGO Agritech** - Tecnologia a serviço da pecuária brasileira 🐑🐐