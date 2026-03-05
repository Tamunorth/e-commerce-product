# E-Commerce Product Catalog

A responsive Flutter product catalog app built with clean architecture, BLoC state management, and a custom design system. Consumes the [DummyJSON](https://dummyjson.com/) products API with offline caching via Hive.

**Live demo**: [tamuno-product-catalog.netlify.app](https://tamuno-product-catalog.netlify.app)

## Features

- **Product browsing** with infinite scroll pagination
- **Search** with 500ms debounce to prevent excessive API calls
- **Category filtering** via horizontal chip row
- **Master-detail layout** on tablet/desktop with draggable resizable divider
- **Responsive grid**: 2 columns on narrow screens, 3 on wider panels, with scaled-up text
- **Product detail** with swipeable image gallery, hover navigation arrows (web), dot indicators, and contained image fit
- **Offline support**: Hive-backed local cache with connectivity banner
- **Light/dark theme** with token-based color system
- **Design system showcase** screen accessible via settings icon
- **Social media previews**: Netlify edge function serves dynamic OG tags for product URLs
- **Hero animations** between list thumbnails and detail gallery

## Architecture

```
lib/
  core/           # DI, networking, theme tokens, constants
  data/           # Models, datasources (remote + local), repository impl
  domain/         # Entities, repository contract, use cases
  presentation/
    design_system/  # 16 reusable DS components + showcase screen
    products/       # Screens, cubits, widgets
    router/         # GoRouter configuration
    shared/         # Shared widgets (staggered animation)
```

**Pattern**: Clean Architecture with BLoC/Cubit for state management. Domain layer has zero dependencies on Flutter or external packages. Data layer handles API calls (Dio) and caching (Hive). Presentation layer uses `BlocSelector` for granular rebuilds.

## Performance

- **Lazy rendering**: `SliverChildBuilderDelegate` and `GridView.builder` only build visible grid items, handling 100+ products without dropped frames
- **Image caching**: `CachedNetworkImage` for lazy loading and disk caching across all image surfaces
- **Search debounce**: 500ms timer prevents API calls on every keystroke
- **Const constructors**: Used throughout (103 instances across 32 files, zero const-related lint warnings)
- **Scoped rebuilds**: `BlocSelector` isolates state changes (search, category, offline, product list, selection) so only affected widgets rebuild
- **Production logging disabled**: Dio `LogInterceptor` only attached in debug mode, Logger level set to `off` in release

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.12+ (Web, iOS, Android) |
| State | flutter_bloc (Cubit) |
| Routing | go_router |
| HTTP | Dio |
| Caching | Hive CE |
| Images | cached_network_image |
| Fonts | Google Fonts (Gelasio, Space Grotesk, Nunito Sans) |
| Icons | iconsax_flutter, Material Icons |
| Hosting | Netlify (edge functions for OG tags) |
| Testing | flutter_test, bloc_test, mocktail |

## Getting Started

```bash
# Clone
git clone https://github.com/Tamunorth/e-commerce-product.git
cd e-commerce-product

# Install dependencies
flutter pub get

# Run (web)
flutter run -d chrome

# Run (mobile)
flutter run

# Run tests
flutter test

# Build for production
flutter build web --release
```

## Design System

Access the component showcase by tapping the settings icon next to the search bar, or navigate to `/showcase`. Components include:

DsButton, DsCard, DsChip, DsChipRow, DsSearchBar, DsRatingBar, DsPriceBadge, DsBadge, DsNetworkImage, DsImageGallery, DsSkeleton, DsSkeletonCard, DsDivider, DsConnectivityBanner, DsEmptyState, DsErrorState

All components respect the light/dark theme tokens defined in `AppColors`.

## Deployment

The app is deployed on Netlify with:

- **SPA redirect**: All routes fall through to `index.html`
- **Edge function**: `/products/:id` routes return product-specific OG meta tags for social media crawlers (Facebook, Twitter, LinkedIn, Slack, Discord, WhatsApp, Telegram, Google, Bing)
- **Static OG tags**: Homepage has generic OG/Twitter Card meta tags

To deploy your own instance:

```bash
flutter build web --release
netlify deploy --prod --dir=build/web
```
