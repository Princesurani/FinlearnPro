# FinlearnPro Development Roadmap & Backlog

Use this file to track the implementation of remaining mock elements, placeholder stubs, and incomplete features. Mark items as completed (`[x]`) as you build them.

---

## 🟥 High Priority (Data Integrity & Live Core Features)

- [ ] **Live Market News & Events Integration**
  - Connect stock details view tabs ([news_tab.dart](file:///Users/prince/Documents/FinlearnPro/lib/features/market/presentation/widgets/stock_detail_tabs/news_tab.dart) and [events_tab.dart](file:///Users/prince/Documents/FinlearnPro/lib/features/market/presentation/widgets/stock_detail_tabs/events_tab.dart)) to the actual backend API news feed route (`GET /api/v1/market/news`).
  - Deprecate private static arrays `_mockNews` and `_mockEvents`.

- [ ] **Persistent Achievements Tracker**
  - Create database schema/models and backend API endpoints to fetch, unlock, and save user achievements.
  - Refactor [learning_progress_service.dart](file:///Users/prince/Documents/FinlearnPro/lib/core/services/learning_progress_service.dart) to persist achievements, removing the local mock initialization.

- [ ] **Real Stock Valuation Statistics**
  - Add API endpoints to fetch live stock financial statistics (P/E ratio, Market Cap, Average Volume, etc.) from live feeds.
  - Update [overview_tab.dart](file:///Users/prince/Documents/FinlearnPro/lib/features/market/presentation/widgets/stock_detail_tabs/overview_tab.dart) to display these backend metrics instead of using the local mathematical formula (`(20 + (price % 50))`).

---

## 🟨 Medium Priority (UI Precision & Polish)

- [ ] **Dynamic Technical Analysis Gauge**
  - Refactor the Technical Analysis indicator needle inside [technicals_tab.dart](file:///Users/prince/Documents/FinlearnPro/lib/features/market/presentation/widgets/stock_detail_tabs/technicals_tab.dart) to calculate gauge angles dynamically using actual technical indicators (RSI, MACD, Moving Averages) instead of rendering a fixed "Strong Buy" canvas offset.

- [ ] **Concrete Course Lesson Contents**
  - Write and register rich markdown lesson slides for empty lessons.
  - Reduce reliance on the boilerplate slide generator (`_generatePlaceholderContent`) in [lesson_screen.dart](file:///Users/prince/Documents/FinlearnPro/lib/features/learning/presentation/pages/lesson_screen.dart).

- [ ] **Dynamic Instructor Biographies**
  - Add details for instructors (bios, photos, and links) to the database models.
  - Refactor [course_details_screen.dart](file:///Users/prince/Documents/FinlearnPro/lib/features/learning/presentation/pages/course_details_screen.dart) to fetch and bind this instructor metadata from the backend.

---

## 🟩 Low Priority (Integrations & Configurations)

- [ ] **Apple Sign-In Integration**
  - Configure Apple Developer Portal credentials and certificates.
  - Implement full Apple Sign-In authentication handlers in [sign_in_screen.dart](file:///Users/prince/Documents/FinlearnPro/lib/features/auth/presentation/pages/sign_in_screen.dart), replacing the SNACKBAR placeholder.

- [ ] **TimescaleDB Production Setup**
  - Install and enable the TimescaleDB extension on the production database host.
  - Deprecate mock candlestick aggregation query fallbacks inside [market.py](file:///Users/prince/Documents/FinlearnPro/backend/api/routes/market.py).

- [ ] **Enforce Unique Display Names**
  - Update user registration flow to prompt for and validate custom user display names.
  - Deprecate default placeholders like `Trader` and `Trader_...` along with display name checking logic inside [social_bloc.dart](file:///Users/prince/Documents/FinlearnPro/lib/features/social/bloc/social_bloc.dart).
