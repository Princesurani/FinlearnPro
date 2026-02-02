# ADR-003: System Architecture & Technical Design

---

# SYSTEM ARCHITECTURE DOCUMENT

This document defines the complete technical architecture for FinLearn Pro, covering system design, technology choices, and implementation patterns.

---

## HIGH-LEVEL ARCHITECTURE

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           CLIENT LAYER                                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   iOS App   │  │ Android App │  │   Web App   │  │  Admin Web  │        │
│  │  (Flutter)  │  │  (Flutter)  │  │  (Flutter)  │  │  (Flutter)  │        │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘        │
└─────────┼────────────────┼────────────────┼────────────────┼────────────────┘
          │                │                │                │
          └────────────────┴────────┬───────┴────────────────┘
                                    │
┌───────────────────────────────────▼─────────────────────────────────────────┐
│                          API GATEWAY LAYER                                   │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                     AWS API Gateway / Kong                            │   │
│  │  • Rate Limiting  • Authentication  • Request Routing  • Caching     │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
└───────────────────────────────────┬─────────────────────────────────────────┘
                                    │
┌───────────────────────────────────▼─────────────────────────────────────────┐
│                         MICROSERVICES LAYER                                  │
│                                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │    Auth     │  │   User      │  │  Learning   │  │   Market    │        │
│  │   Service   │  │  Service    │  │   Service   │  │  Service    │        │
│  │  (Node.js)  │  │  (Node.js)  │  │  (Node.js)  │  │  (Python)   │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │  Portfolio  │  │   Trading   │  │     AI      │  │   Social    │        │
│  │   Service   │  │   Service   │  │   Service   │  │   Service   │        │
│  │  (Node.js)  │  │  (Node.js)  │  │  (Python)   │  │  (Node.js)  │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │ Gamification│  │   Notifi-   │  │  Analytics  │  │   Admin     │        │
│  │   Service   │  │   cation    │  │   Service   │  │   Service   │        │
│  │  (Node.js)  │  │   Service   │  │  (Python)   │  │  (Node.js)  │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
└───────────────────────────────────┬─────────────────────────────────────────┘
                                    │
┌───────────────────────────────────▼─────────────────────────────────────────┐
│                           DATA LAYER                                         │
│                                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │ PostgreSQL  │  │   MongoDB   │  │    Redis    │  │Elasticsearch│        │
│  │(Relational) │  │ (Document)  │  │  (Cache)    │  │  (Search)   │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                         │
│  │   AWS S3    │  │  TimescaleDB│  │   Apache    │                         │
│  │ (Storage)   │  │(Time Series)│  │   Kafka     │                         │
│  └─────────────┘  └─────────────┘  └─────────────┘                         │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
┌───────────────────────────────────▼─────────────────────────────────────────┐
│                         EXTERNAL SERVICES                                    │
│                                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   OpenAI    │  │   Firebase  │  │    AWS      │  │   Stripe    │        │
│  │    API      │  │  (Auth/FCM) │  │  Services   │  │ (Payments)  │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## FLUTTER APPLICATION ARCHITECTURE

### Clean Architecture with BLoC Pattern

```
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── api_endpoints.dart
│   │   ├── asset_paths.dart
│   │   ├── route_names.dart
│   │   └── storage_keys.dart
│   │
│   ├── themes/
│   │   ├── app_theme.dart
│   │   ├── light_theme.dart
│   │   ├── dark_theme.dart
│   │   ├── colors.dart
│   │   ├── typography.dart
│   │   └── dimensions.dart
│   │
│   ├── utils/
│   │   ├── extensions/
│   │   │   ├── string_extensions.dart
│   │   │   ├── number_extensions.dart
│   │   │   ├── date_extensions.dart
│   │   │   └── context_extensions.dart
│   │   ├── helpers/
│   │   │   ├── validator.dart
│   │   │   ├── formatter.dart
│   │   │   ├── calculator.dart
│   │   │   └── logger.dart
│   │   └── enums/
│   │       ├── order_type.dart
│   │       ├── asset_class.dart
│   │       └── user_level.dart
│   │
│   ├── errors/
│   │   ├── failures.dart
│   │   ├── exceptions.dart
│   │   └── error_handler.dart
│   │
│   ├── network/
│   │   ├── api_client.dart
│   │   ├── dio_client.dart
│   │   ├── interceptors/
│   │   │   ├── auth_interceptor.dart
│   │   │   ├── logging_interceptor.dart
│   │   │   └── error_interceptor.dart
│   │   └── network_info.dart
│   │
│   ├── services/
│   │   ├── storage_service.dart
│   │   ├── notification_service.dart
│   │   ├── analytics_service.dart
│   │   ├── deep_link_service.dart
│   │   └── crash_reporting_service.dart
│   │
│   └── di/
│       ├── injection_container.dart
│       └── modules/
│           ├── network_module.dart
│           ├── storage_module.dart
│           └── service_module.dart
│
├── features/
│   │
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   └── auth_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   └── token_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── user.dart
│   │   │   │   └── auth_token.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── login_usecase.dart
│   │   │       ├── register_usecase.dart
│   │   │       ├── logout_usecase.dart
│   │   │       ├── forgot_password_usecase.dart
│   │   │       └── social_login_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   ├── register_page.dart
│   │       │   ├── forgot_password_page.dart
│   │       │   └── otp_verification_page.dart
│   │       └── widgets/
│   │           ├── login_form.dart
│   │           ├── social_login_buttons.dart
│   │           └── auth_header.dart
│   │
│   ├── onboarding/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       │   ├── welcome_page.dart
│   │       │   ├── experience_assessment_page.dart
│   │       │   ├── risk_profile_page.dart
│   │       │   ├── interest_selection_page.dart
│   │       │   ├── learning_style_page.dart
│   │       │   └── schedule_setup_page.dart
│   │       └── widgets/
│   │
│   ├── learning/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── learning_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── course_model.dart
│   │   │   │   ├── lesson_model.dart
│   │   │   │   ├── quiz_model.dart
│   │   │   │   └── progress_model.dart
│   │   │   └── repositories/
│   │   │       └── learning_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── course.dart
│   │   │   │   ├── lesson.dart
│   │   │   │   ├── quiz.dart
│   │   │   │   ├── question.dart
│   │   │   │   └── user_progress.dart
│   │   │   ├── repositories/
│   │   │   │   └── learning_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_courses_usecase.dart
│   │   │       ├── get_lesson_usecase.dart
│   │   │       ├── submit_quiz_usecase.dart
│   │   │       └── update_progress_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── learning_bloc.dart
│   │       │   ├── course_bloc.dart
│   │       │   ├── lesson_bloc.dart
│   │       │   └── quiz_bloc.dart
│   │       ├── pages/
│   │       │   ├── learning_home_page.dart
│   │       │   ├── course_detail_page.dart
│   │       │   ├── lesson_page.dart
│   │       │   ├── quiz_page.dart
│   │       │   └── certificate_page.dart
│   │       └── widgets/
│   │           ├── course_card.dart
│   │           ├── lesson_card.dart
│   │           ├── progress_indicator.dart
│   │           ├── video_player.dart
│   │           ├── interactive_content.dart
│   │           └── quiz_question_widget.dart
│   │
│   ├── market/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── market_remote_datasource.dart
│   │   │   │   ├── market_websocket_datasource.dart
│   │   │   │   └── market_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── stock_model.dart
│   │   │   │   ├── quote_model.dart
│   │   │   │   ├── ohlc_model.dart
│   │   │   │   ├── order_book_model.dart
│   │   │   │   └── market_news_model.dart
│   │   │   └── repositories/
│   │   │       └── market_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── stock.dart
│   │   │   │   ├── quote.dart
│   │   │   │   ├── candle.dart
│   │   │   │   ├── order_book.dart
│   │   │   │   └── market_news.dart
│   │   │   ├── repositories/
│   │   │   │   └── market_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_quote_usecase.dart
│   │   │       ├── get_chart_data_usecase.dart
│   │   │       ├── search_stocks_usecase.dart
│   │   │       └── subscribe_realtime_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── market_bloc.dart
│   │       │   ├── watchlist_bloc.dart
│   │       │   ├── chart_bloc.dart
│   │       │   └── news_bloc.dart
│   │       ├── pages/
│   │       │   ├── market_overview_page.dart
│   │       │   ├── stock_detail_page.dart
│   │       │   ├── watchlist_page.dart
│   │       │   └── market_news_page.dart
│   │       └── widgets/
│   │           ├── stock_quote_widget.dart
│   │           ├── candlestick_chart.dart
│   │           ├── technical_indicators.dart
│   │           ├── order_book_widget.dart
│   │           └── news_card.dart
│   │
│   ├── trading/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── trading_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── order_model.dart
│   │   │   │   ├── position_model.dart
│   │   │   │   └── execution_model.dart
│   │   │   └── repositories/
│   │   │       └── trading_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── order.dart
│   │   │   │   ├── position.dart
│   │   │   │   └── execution.dart
│   │   │   ├── repositories/
│   │   │   │   └── trading_repository.dart
│   │   │   └── usecases/
│   │   │       ├── place_order_usecase.dart
│   │   │       ├── cancel_order_usecase.dart
│   │   │       ├── modify_order_usecase.dart
│   │   │       └── get_orders_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── trading_bloc.dart
│   │       │   ├── order_bloc.dart
│   │       │   └── position_bloc.dart
│   │       ├── pages/
│   │       │   ├── trade_ticket_page.dart
│   │       │   ├── order_preview_page.dart
│   │       │   ├── order_history_page.dart
│   │       │   └── options_chain_page.dart
│   │       └── widgets/
│   │           ├── trade_form.dart
│   │           ├── order_type_selector.dart
│   │           ├── quantity_input.dart
│   │           └── order_confirmation.dart
│   │
│   ├── portfolio/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── portfolio_bloc.dart
│   │       │   └── holdings_bloc.dart
│   │       ├── pages/
│   │       │   ├── portfolio_dashboard_page.dart
│   │       │   ├── holdings_page.dart
│   │       │   ├── transactions_page.dart
│   │       │   └── performance_page.dart
│   │       └── widgets/
│   │           ├── portfolio_summary.dart
│   │           ├── holdings_list.dart
│   │           ├── allocation_chart.dart
│   │           └── performance_chart.dart
│   │
│   ├── ai_advisor/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── ai_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── chat_message_model.dart
│   │   │   │   ├── portfolio_analysis_model.dart
│   │   │   │   └── recommendation_model.dart
│   │   │   └── repositories/
│   │   │       └── ai_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── chat_message.dart
│   │   │   │   ├── portfolio_analysis.dart
│   │   │   │   └── recommendation.dart
│   │   │   ├── repositories/
│   │   │   │   └── ai_repository.dart
│   │   │   └── usecases/
│   │   │       ├── send_message_usecase.dart
│   │   │       ├── analyze_portfolio_usecase.dart
│   │   │       ├── get_recommendations_usecase.dart
│   │   │       └── what_if_analysis_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── chat_bloc.dart
│   │       │   └── analysis_bloc.dart
│   │       ├── pages/
│   │       │   ├── ai_chat_page.dart
│   │       │   ├── portfolio_analysis_page.dart
│   │       │   └── recommendations_page.dart
│   │       └── widgets/
│   │           ├── chat_bubble.dart
│   │           ├── typing_indicator.dart
│   │           ├── analysis_card.dart
│   │           └── recommendation_card.dart
│   │
│   ├── social/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       │   ├── community_feed_page.dart
│   │       │   ├── profile_page.dart
│   │       │   ├── leaderboard_page.dart
│   │       │   └── competitions_page.dart
│   │       └── widgets/
│   │
│   ├── gamification/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       │   ├── achievements_page.dart
│   │       │   ├── rewards_page.dart
│   │       │   └── challenges_page.dart
│   │       └── widgets/
│   │           ├── achievement_badge.dart
│   │           ├── xp_bar.dart
│   │           └── challenge_card.dart
│   │
│   ├── analytics/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       │   ├── analytics_dashboard_page.dart
│   │       │   ├── trade_analytics_page.dart
│   │       │   └── risk_analytics_page.dart
│   │       └── widgets/
│   │
│   └── settings/
│       ├── data/
│       ├── domain/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           │   ├── settings_page.dart
│           │   ├── notifications_settings_page.dart
│           │   ├── appearance_settings_page.dart
│           │   └── privacy_settings_page.dart
│           └── widgets/
│
├── shared/
│   ├── widgets/
│   │   ├── buttons/
│   │   │   ├── primary_button.dart
│   │   │   ├── secondary_button.dart
│   │   │   ├── icon_button.dart
│   │   │   └── loading_button.dart
│   │   ├── inputs/
│   │   │   ├── text_field.dart
│   │   │   ├── search_field.dart
│   │   │   ├── dropdown.dart
│   │   │   └── number_input.dart
│   │   ├── dialogs/
│   │   │   ├── alert_dialog.dart
│   │   │   ├── confirmation_dialog.dart
│   │   │   └── loading_dialog.dart
│   │   ├── cards/
│   │   │   ├── base_card.dart
│   │   │   └── gradient_card.dart
│   │   ├── charts/
│   │   │   ├── line_chart_widget.dart
│   │   │   ├── pie_chart_widget.dart
│   │   │   ├── bar_chart_widget.dart
│   │   │   └── candlestick_chart_widget.dart
│   │   ├── loading/
│   │   │   ├── shimmer_loading.dart
│   │   │   ├── skeleton_loading.dart
│   │   │   └── progress_indicator.dart
│   │   └── empty_states/
│   │       ├── empty_list.dart
│   │       ├── error_state.dart
│   │       └── no_connection.dart
│   │
│   └── navigation/
│       ├── app_router.dart
│       ├── route_guards.dart
│       └── navigation_service.dart
│
└── config/
    ├── environment.dart
    ├── app_config.dart
    └── flavor_config.dart
```

---

## STATE MANAGEMENT ARCHITECTURE

### BLoC Pattern Implementation

```dart
// Example: Portfolio BLoC Structure

// portfolio_event.dart
abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();
}

class LoadPortfolio extends PortfolioEvent {
  final String portfolioId;
  const LoadPortfolio(this.portfolioId);
  
  @override
  List<Object> get props => [portfolioId];
}

class RefreshPortfolio extends PortfolioEvent {
  @override
  List<Object> get props => [];
}

class UpdateHolding extends PortfolioEvent {
  final String holdingId;
  final double quantity;
  const UpdateHolding(this.holdingId, this.quantity);
  
  @override
  List<Object> get props => [holdingId, quantity];
}

// portfolio_state.dart
abstract class PortfolioState extends Equatable {
  const PortfolioState();
}

class PortfolioInitial extends PortfolioState {
  @override
  List<Object> get props => [];
}

class PortfolioLoading extends PortfolioState {
  @override
  List<Object> get props => [];
}

class PortfolioLoaded extends PortfolioState {
  final Portfolio portfolio;
  final List<Holding> holdings;
  final PortfolioMetrics metrics;
  
  const PortfolioLoaded({
    required this.portfolio,
    required this.holdings,
    required this.metrics,
  });
  
  @override
  List<Object> get props => [portfolio, holdings, metrics];
}

class PortfolioError extends PortfolioState {
  final String message;
  const PortfolioError(this.message);
  
  @override
  List<Object> get props => [message];
}

// portfolio_bloc.dart
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolioUseCase getPortfolioUseCase;
  final UpdateHoldingUseCase updateHoldingUseCase;
  
  PortfolioBloc({
    required this.getPortfolioUseCase,
    required this.updateHoldingUseCase,
  }) : super(PortfolioInitial()) {
    on<LoadPortfolio>(_onLoadPortfolio);
    on<RefreshPortfolio>(_onRefreshPortfolio);
    on<UpdateHolding>(_onUpdateHolding);
  }
  
  Future<void> _onLoadPortfolio(
    LoadPortfolio event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(PortfolioLoading());
    
    final result = await getPortfolioUseCase(event.portfolioId);
    
    result.fold(
      (failure) => emit(PortfolioError(failure.message)),
      (data) => emit(PortfolioLoaded(
        portfolio: data.portfolio,
        holdings: data.holdings,
        metrics: data.metrics,
      )),
    );
  }
  
  // ... other handlers
}
```

### State Management Layers

```
┌─────────────────────────────────────────────────┐
│                  UI LAYER                        │
│  Widgets receive state and dispatch events       │
└───────────────────────┬─────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────┐
│                  BLOC LAYER                      │
│  Receives events, processes logic, emits states  │
└───────────────────────┬─────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────┐
│               USE CASE LAYER                     │
│  Business logic, validation, transformation      │
└───────────────────────┬─────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────┐
│              REPOSITORY LAYER                    │
│  Data access abstraction                         │
└───────────────────────┬─────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────┐
│             DATA SOURCE LAYER                    │
│  Remote API, Local Storage, WebSocket            │
└─────────────────────────────────────────────────┘
```

---

## DATABASE SCHEMA DESIGN

### PostgreSQL Schema (Relational Data)

```sql
-- Users and Authentication
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    avatar_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE user_profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    experience_level VARCHAR(50),
    risk_tolerance INTEGER CHECK (risk_tolerance BETWEEN 1 AND 10),
    investment_goal VARCHAR(100),
    learning_style VARCHAR(50),
    daily_time_minutes INTEGER,
    preferred_time VARCHAR(50),
    onboarding_completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Portfolios
CREATE TABLE portfolios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    initial_balance DECIMAL(15,2) DEFAULT 100000.00,
    current_balance DECIMAL(15,2),
    cash_available DECIMAL(15,2),
    portfolio_type VARCHAR(50) DEFAULT 'main',
    benchmark VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE holdings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    portfolio_id UUID REFERENCES portfolios(id) ON DELETE CASCADE,
    symbol VARCHAR(20) NOT NULL,
    quantity DECIMAL(15,6) NOT NULL,
    average_cost DECIMAL(15,4) NOT NULL,
    current_price DECIMAL(15,4),
    asset_type VARCHAR(50) DEFAULT 'stock',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders and Trades
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    portfolio_id UUID REFERENCES portfolios(id) ON DELETE CASCADE,
    symbol VARCHAR(20) NOT NULL,
    order_type VARCHAR(50) NOT NULL,
    side VARCHAR(10) NOT NULL, -- BUY or SELL
    quantity DECIMAL(15,6) NOT NULL,
    limit_price DECIMAL(15,4),
    stop_price DECIMAL(15,4),
    time_in_force VARCHAR(20) DEFAULT 'DAY',
    status VARCHAR(50) DEFAULT 'pending',
    filled_quantity DECIMAL(15,6) DEFAULT 0,
    average_fill_price DECIMAL(15,4),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    filled_at TIMESTAMP,
    cancelled_at TIMESTAMP
);

CREATE TABLE transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    portfolio_id UUID REFERENCES portfolios(id) ON DELETE CASCADE,
    order_id UUID REFERENCES orders(id),
    symbol VARCHAR(20) NOT NULL,
    transaction_type VARCHAR(50) NOT NULL,
    quantity DECIMAL(15,6) NOT NULL,
    price DECIMAL(15,4) NOT NULL,
    total_amount DECIMAL(15,2) NOT NULL,
    commission DECIMAL(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Learning Progress
CREATE TABLE user_course_progress (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    course_id VARCHAR(100) NOT NULL,
    status VARCHAR(50) DEFAULT 'not_started',
    progress_percentage INTEGER DEFAULT 0,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    last_accessed_at TIMESTAMP
);

CREATE TABLE user_lesson_progress (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    lesson_id VARCHAR(100) NOT NULL,
    course_id VARCHAR(100) NOT NULL,
    status VARCHAR(50) DEFAULT 'not_started',
    completed BOOLEAN DEFAULT FALSE,
    time_spent_seconds INTEGER DEFAULT 0,
    started_at TIMESTAMP,
    completed_at TIMESTAMP
);

CREATE TABLE quiz_attempts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    quiz_id VARCHAR(100) NOT NULL,
    score INTEGER NOT NULL,
    max_score INTEGER NOT NULL,
    passed BOOLEAN NOT NULL,
    time_taken_seconds INTEGER,
    answers JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Gamification
CREATE TABLE user_achievements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    achievement_id VARCHAR(100) NOT NULL,
    unlocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, achievement_id)
);

CREATE TABLE user_xp (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE UNIQUE,
    total_xp INTEGER DEFAULT 0,
    level INTEGER DEFAULT 1,
    streak_days INTEGER DEFAULT 0,
    last_activity_date DATE,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Social
CREATE TABLE user_follows (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    follower_id UUID REFERENCES users(id) ON DELETE CASCADE,
    following_id UUID REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(follower_id, following_id)
);

-- Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_holdings_portfolio ON holdings(portfolio_id);
CREATE INDEX idx_orders_portfolio ON orders(portfolio_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_transactions_portfolio ON transactions(portfolio_id);
CREATE INDEX idx_user_progress_user ON user_course_progress(user_id);
```

### MongoDB Schema (Document Data)

```javascript
// Courses Collection
{
  "_id": ObjectId,
  "course_id": "course_1_1",
  "title": "What is the Stock Market?",
  "description": "Learn the fundamentals...",
  "level": "beginner",
  "category": "foundation",
  "estimated_duration_minutes": 120,
  "lessons": [
    {
      "lesson_id": "lesson_1_1_1",
      "title": "History of Stock Markets",
      "order": 1,
      "content": {
        "video_url": "https://...",
        "video_duration_seconds": 480,
        "text_content": "...",
        "key_points": ["point1", "point2"],
        "interactive_elements": [
          {
            "type": "drag_drop",
            "data": {...}
          }
        ]
      },
      "quiz": {
        "questions": [
          {
            "question_id": "q1",
            "type": "multiple_choice",
            "question": "When was NYSE founded?",
            "options": ["1792", "1800", "1850", "1900"],
            "correct_answer": 0,
            "explanation": "The NYSE was founded in 1792..."
          }
        ],
        "pass_score": 80
      }
    }
  ],
  "prerequisites": [],
  "tags": ["basics", "markets", "history"],
  "created_at": ISODate,
  "updated_at": ISODate
}

// Market Data Collection (for historical scenarios)
{
  "_id": ObjectId,
  "scenario_id": "2008_financial_crisis",
  "name": "2008 Financial Crisis",
  "description": "Experience the market crash...",
  "start_date": ISODate("2008-09-01"),
  "end_date": ISODate("2009-03-31"),
  "market_data": {
    "AAPL": [
      {
        "date": ISODate("2008-09-01"),
        "open": 169.53,
        "high": 173.56,
        "low": 168.13,
        "close": 172.55,
        "volume": 12500000,
        "adjusted_close": 21.89
      }
    ]
  },
  "news_events": [
    {
      "date": ISODate("2008-09-15"),
      "headline": "Lehman Brothers Files for Bankruptcy",
      "impact": "severe_negative",
      "affected_sectors": ["financials", "all"]
    }
  ],
  "learning_objectives": [
    "Understand how fear drives market selling",
    "Learn about systemic risk"
  ]
}

// AI Chat History Collection
{
  "_id": ObjectId,
  "user_id": "user_uuid",
  "conversation_id": "conv_uuid",
  "messages": [
    {
      "message_id": "msg_1",
      "role": "user",
      "content": "Is my portfolio too risky?",
      "timestamp": ISODate
    },
    {
      "message_id": "msg_2",
      "role": "assistant",
      "content": "Based on my analysis...",
      "context": {
        "portfolio_snapshot": {...},
        "analysis_performed": ["risk_assessment", "beta_calculation"]
      },
      "timestamp": ISODate
    }
  ],
  "created_at": ISODate,
  "updated_at": ISODate
}

// Notifications Collection
{
  "_id": ObjectId,
  "user_id": "user_uuid",
  "type": "price_alert",
  "title": "AAPL Price Alert",
  "body": "AAPL has reached your target price of $150",
  "data": {
    "symbol": "AAPL",
    "price": 150.25,
    "alert_type": "target_reached"
  },
  "read": false,
  "created_at": ISODate
}
```

### TimescaleDB Schema (Time-Series Data)

```sql
-- Enable TimescaleDB extension
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- Simulated Market Data (for real-time simulation)
CREATE TABLE market_ticks (
    time TIMESTAMPTZ NOT NULL,
    symbol VARCHAR(20) NOT NULL,
    price DECIMAL(15,4) NOT NULL,
    bid DECIMAL(15,4),
    ask DECIMAL(15,4),
    volume BIGINT,
    change_percent DECIMAL(8,4)
);

-- Convert to hypertable for time-series optimization
SELECT create_hypertable('market_ticks', 'time');

-- Create indexes for common queries
CREATE INDEX idx_market_ticks_symbol_time ON market_ticks (symbol, time DESC);

-- Portfolio Snapshots (for performance tracking)
CREATE TABLE portfolio_snapshots (
    time TIMESTAMPTZ NOT NULL,
    portfolio_id UUID NOT NULL,
    total_value DECIMAL(15,2) NOT NULL,
    cash_balance DECIMAL(15,2) NOT NULL,
    holdings_value DECIMAL(15,2) NOT NULL,
    day_change DECIMAL(15,2),
    day_change_percent DECIMAL(8,4)
);

SELECT create_hypertable('portfolio_snapshots', 'time');

-- User Activity Analytics
CREATE TABLE user_activity (
    time TIMESTAMPTZ NOT NULL,
    user_id UUID NOT NULL,
    activity_type VARCHAR(50) NOT NULL,
    feature VARCHAR(100),
    duration_seconds INTEGER,
    metadata JSONB
);

SELECT create_hypertable('user_activity', 'time');
```

---

## API DESIGN

### RESTful API Structure

```yaml
Base URL: https://api.finlearnpro.com/v1

Authentication:
  POST   /auth/register          # User registration
  POST   /auth/login             # User login
  POST   /auth/logout            # User logout
  POST   /auth/refresh           # Refresh token
  POST   /auth/forgot-password   # Request password reset
  POST   /auth/reset-password    # Reset password
  POST   /auth/verify-email      # Verify email
  POST   /auth/social/{provider} # Social login

Users:
  GET    /users/me               # Get current user
  PUT    /users/me               # Update user profile
  GET    /users/me/progress      # Get learning progress
  GET    /users/me/achievements  # Get achievements
  DELETE /users/me               # Delete account

Learning:
  GET    /courses                # List all courses
  GET    /courses/{id}           # Get course details
  GET    /courses/{id}/lessons   # Get course lessons
  GET    /lessons/{id}           # Get lesson content
  POST   /lessons/{id}/complete  # Mark lesson complete
  GET    /quizzes/{id}           # Get quiz
  POST   /quizzes/{id}/submit    # Submit quiz answers

Portfolios:
  GET    /portfolios             # List user portfolios
  POST   /portfolios             # Create portfolio
  GET    /portfolios/{id}        # Get portfolio details
  PUT    /portfolios/{id}        # Update portfolio
  DELETE /portfolios/{id}        # Delete portfolio
  GET    /portfolios/{id}/holdings      # Get holdings
  GET    /portfolios/{id}/transactions  # Get transactions
  GET    /portfolios/{id}/performance   # Get performance metrics

Trading:
  POST   /orders                 # Place order
  GET    /orders                 # Get user orders
  GET    /orders/{id}            # Get order details
  PUT    /orders/{id}            # Modify order
  DELETE /orders/{id}            # Cancel order

Market:
  GET    /market/quote/{symbol}  # Get quote
  GET    /market/quotes          # Get multiple quotes
  GET    /market/chart/{symbol}  # Get chart data
  GET    /market/search          # Search symbols
  GET    /market/news            # Get market news
  GET    /market/movers          # Get market movers

Watchlists:
  GET    /watchlists             # Get user watchlists
  POST   /watchlists             # Create watchlist
  PUT    /watchlists/{id}        # Update watchlist
  DELETE /watchlists/{id}        # Delete watchlist
  POST   /watchlists/{id}/symbols       # Add symbol
  DELETE /watchlists/{id}/symbols/{sym} # Remove symbol

AI:
  POST   /ai/chat                # Send chat message
  GET    /ai/chat/history        # Get chat history
  POST   /ai/analyze-portfolio   # Analyze portfolio
  POST   /ai/what-if             # What-if analysis
  GET    /ai/recommendations     # Get recommendations

Social:
  GET    /users/{id}/profile     # Get user public profile
  POST   /users/{id}/follow      # Follow user
  DELETE /users/{id}/follow      # Unfollow user
  GET    /feed                   # Get social feed
  POST   /posts                  # Create post
  GET    /leaderboard            # Get leaderboard

Gamification:
  GET    /achievements           # List all achievements
  GET    /challenges             # Get active challenges
  POST   /challenges/{id}/join   # Join challenge
  GET    /rewards                # Get available rewards
```

### WebSocket API

```yaml
WebSocket URL: wss://ws.finlearnpro.com/v1

Channels:
  market:
    - subscribe: { "action": "subscribe", "channel": "market", "symbols": ["AAPL", "GOOGL"] }
    - unsubscribe: { "action": "unsubscribe", "channel": "market", "symbols": ["AAPL"] }
    - message: { "type": "quote", "symbol": "AAPL", "data": {...} }
  
  portfolio:
    - subscribe: { "action": "subscribe", "channel": "portfolio", "portfolio_id": "..." }
    - message: { "type": "update", "data": {...} }
  
  orders:
    - subscribe: { "action": "subscribe", "channel": "orders" }
    - message: { "type": "order_update", "data": {...} }
  
  notifications:
    - subscribe: { "action": "subscribe", "channel": "notifications" }
    - message: { "type": "notification", "data": {...} }
```

---

## SECURITY ARCHITECTURE

### Authentication Flow

```
┌─────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Client │────│  API Gateway │────│ Auth Service│────│   Database  │
└────┬────┘    └──────┬──────┘    └──────┬──────┘    └──────┬──────┘
     │                │                   │                  │
     │  Login Request │                   │                  │
     │───────────────>│                   │                  │
     │                │  Validate Creds   │                  │
     │                │──────────────────>│                  │
     │                │                   │   Query User     │
     │                │                   │─────────────────>│
     │                │                   │                  │
     │                │                   │   User Data      │
     │                │                   │<─────────────────│
     │                │                   │                  │
     │                │  Generate Tokens  │                  │
     │                │<──────────────────│                  │
     │                │                   │                  │
     │  Access Token  │                   │                  │
     │  + Refresh Token                   │                  │
     │<───────────────│                   │                  │
```

### Security Measures

```yaml
Authentication:
  - JWT with RS256 signing
  - Access token: 15 minutes expiry
  - Refresh token: 7 days expiry, rotation on use
  - Token blacklisting on logout

Authorization:
  - Role-based access control (RBAC)
  - Resource-level permissions
  - API rate limiting per user

Data Protection:
  - TLS 1.3 for all connections
  - AES-256 encryption for sensitive data at rest
  - HTTPS-only endpoints
  - Secure cookie settings

API Security:
  - Request signing for critical operations
  - Input validation and sanitization
  - SQL injection prevention (parameterized queries)
  - XSS prevention (output encoding)
  - CSRF protection

Mobile App Security:
  - Certificate pinning
  - Root/jailbreak detection
  - Code obfuscation
  - Secure storage for tokens
  - Biometric authentication support

Monitoring:
  - Real-time threat detection
  - Anomaly detection for unusual activity
  - Comprehensive audit logging
  - Automated incident response
```

---

## SCALABILITY DESIGN

### Horizontal Scaling Strategy

```
                    ┌─────────────────┐
                    │  Load Balancer  │
                    └────────┬────────┘
                             │
         ┌───────────────────┼───────────────────┐
         │                   │                   │
    ┌────▼────┐         ┌────▼────┐         ┌────▼────┐
    │ Server 1│         │ Server 2│         │ Server N│
    │  (K8s)  │         │  (K8s)  │         │  (K8s)  │
    └────┬────┘         └────┬────┘         └────┬────┘
         │                   │                   │
         └───────────────────┼───────────────────┘
                             │
                    ┌────────▼────────┐
                    │  Message Queue  │
                    │    (Kafka)      │
                    └────────┬────────┘
                             │
         ┌───────────────────┼───────────────────┐
         │                   │                   │
    ┌────▼────┐         ┌────▼────┐         ┌────▼────┐
    │Worker 1 │         │Worker 2 │         │Worker N │
    └─────────┘         └─────────┘         └─────────┘
```

### Caching Strategy

```yaml
Cache Layers:
  
  CDN (CloudFront):
    - Static assets
    - Course media content
    - Public API responses

  Redis Cluster:
    - User sessions
    - Real-time market data
    - Leaderboards
    - Rate limiting counters
    - Hot user data

  Application Cache:
    - Frequently accessed entities
    - Configuration data
    - Feature flags

Cache Invalidation:
  - TTL-based expiration
  - Event-driven invalidation
  - Manual purge endpoints
```

---

## TESTING STRATEGY

```yaml
Testing Layers:

Unit Tests:
  - Coverage target: > 80%
  - Focus: Business logic, utilities, calculations
  - Tools: flutter_test, mockito

Widget Tests:
  - Coverage target: > 70%
  - Focus: UI components, user interactions
  - Tools: flutter_test, golden tests

Integration Tests:
  - Coverage target: > 60%
  - Focus: Feature flows, API integration
  - Tools: integration_test package

E2E Tests:
  - Critical user journeys
  - Tools: flutter_driver, Appium

Performance Tests:
  - Load testing: k6, Artillery
  - API performance: < 200ms p95
  - App startup: < 3 seconds

Security Tests:
  - Penetration testing
  - OWASP compliance checks
  - Dependency vulnerability scanning
```

---

*Document Version: 1.0*
*Last Updated: January 29, 2026*
